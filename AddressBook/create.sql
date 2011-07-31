sqlite3 Leisureliness.db

CREATE TABLE images (
    'url'                    TEXT PRIMARY KEY,
    'image'                  BLOB,
    'updated_at'             DATETIME
);

CREATE TABLE newslist (
    'news_id' TEXT PRIMARY KEY,
    'channel_id' TEXT,
    'news_title' TEXT,
    'news_url' TEXT,
    'news_pubdate' DATETIME,
    'news_favorite' INTEGER,
    'news_readed' INTEGER
);

CREATE TABLE newscontent (
    'content_id'             TEXT,
    'news_id'                TEXT PRIMARY KEY,
    'content'                TEXT,
    'content_page'           INTEGER,
    'content_comment'        INTEGER,
    'content_title'          TEXT	 
);