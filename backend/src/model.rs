use serde::Serialize;
use std::collections::HashSet;

#[derive(Serialize)]
pub struct Song {
    pub id: i32,
    pub album_id: i32,
    pub title: String,
    pub filetype: String,
    pub media: i32,
    pub artists: HashSet<(i32, String)>
}

