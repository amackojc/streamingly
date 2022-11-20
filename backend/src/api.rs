use actix_web::{web, HttpRequest, HttpResponse, Responder};
use mysql::prelude::Queryable;
use std::collections::{HashMap};
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




pub fn init(cfg: &mut web::ServiceConfig) {
 

    cfg.route("/api/songs", web::get().to(songs));
    cfg.route("/api/songs/{id}", web::get().to(songs));
}
