use serde::Serialize;

#[derive(Serialize)]
pub struct Song {
    pub id: i32,
    pub album_id: i32,
    pub title: String,
    pub filetype: String,
    pub media: i32,
}

