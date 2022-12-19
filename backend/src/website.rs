use actix_web::{web, HttpRequest, Result};
use actix_files::{Files, NamedFile};

pub fn init(cfg: &mut web::ServiceConfig) {
    cfg.route("/", web::get().to(index));
    cfg.route("/artists{rest:.*}", web::get().to(index));
    cfg.route("/genre{rest:.*}", web::get().to(index));
    cfg.service(Files::new("/static", "/home/alex/streamingly/out/static"));
}

async fn index(_req: HttpRequest) -> Result<NamedFile> {
    Ok(NamedFile::open(get_path!("static/index.html"))?)
}

