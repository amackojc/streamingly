use crate::model::{Song};
use actix_web::{web, HttpRequest, HttpResponse, Responder};
use mysql::prelude::Queryable;
use std::collections::{HashMap, HashSet};
use crate::common::*;

macro_rules! get_limit_and_offset {
    ($query:ident, $limit:ident, $offset:ident) => {
        let $limit = match $query.get("limit") {
            None => Ok(5),
            Some(ref x) => x.parse::<i32>(),
        };
        if let Err(_) = $limit {
            return HttpResponse::BadRequest().finish();
        }
        let $limit = $limit.unwrap();
        let $offset = match $query.get("offset") {
            None => Ok(0),
            Some(ref x) => x.parse::<i32>(),
        };
        if let Err(_) = $offset {
            return HttpResponse::BadRequest().finish();
        }
        let $offset = $offset.unwrap();
    }
}

fn parse_songs(output: Vec<(i32, i32, String, String, i32, i32, String, i32, String)>) -> Vec<Song> {
    let mut songs: HashMap<i32, Song> = HashMap::new();
    for row in output {
        let song = songs.entry(row.0).or_insert(
                Song {
                    id: row.0,
                    album_id: row.1,
                    title: row.2,
                    filetype: row.3,
                    media: row.4,
                    genres: HashSet::new(),
                    artists: HashSet::new(),
                });
        song.genres.insert((row.5, row.6));
        song.artists.insert((row.7, row.8));
    }
    songs.into_iter().map(|(_, song)| song).collect()
}

async fn songs(req: HttpRequest, query: web::Query<HashMap<String, String>>) -> impl Responder {
    get_path_variable!("id", id, req);
    get_limit_and_offset!(query, limit, offset);
    get_db_conn!(conn, req);

    let output = if let Some(id) = id {
        let stmt = conn.prep("
            SELECT
                s.id,
                s.album_id,
                s.title,
                s.filetype,
                s.song_media,
                g.id,
                g.name,
                a.id,
                a.name
            FROM
                songs as s
            INNER JOIN song_genre as sg
                ON s.id = sg.song_id
            INNER JOIN song_artist as sa
                ON s.id = sa.song_id
            INNER JOIN genres as g
                ON g.id = sg.genre_id
            INNER JOIN artists as a
                ON a.id = sa.artist_id
            WHERE
                s.id = ?;").unwrap();
        conn.exec(stmt, (id,)).unwrap()
    } else {
        let stmt = conn.prep("WITH songs_ids as (
            SELECT
                id,
                ROW_NUMBER() OVER(ORDER BY id) as num
            FROM
                songs
            )
            SELECT
                s.id,
                s.album_id,
                s.title,
                s.filetype,
                s.song_media,
                g.id,
                g.name,
                a.id,
                a.name
            FROM
                songs as s
            INNER JOIN song_genre as sg
                ON s.id = sg.song_id
            INNER JOIN song_artist as sa
                ON s.id = sa.song_id
            INNER JOIN genres as g
                ON g.id = sg.genre_id
            INNER JOIN artists as a
                ON a.id = sa.artist_id
            INNER JOIN songs_ids as si
                ON s.id = si.id
            WHERE
                si.num > ? and si.num <= ?;").unwrap();
        conn.exec(stmt, (offset, limit+offset)).unwrap()
    };
    let songs = parse_songs(output);
    HttpResponse::Ok().json(songs)
}


pub fn init(cfg: &mut web::ServiceConfig) {
 

    cfg.route("/api/songs", web::get().to(songs));
    cfg.route("/api/songs/{id}", web::get().to(songs));
}
