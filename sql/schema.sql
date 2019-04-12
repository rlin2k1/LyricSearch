DROP SCHEMA IF EXISTS searchengine CASCADE;
CREATE SCHEMA IF NOT EXISTS searchengine;

CREATE TABLE searchengine.artists(
    artist_id smallint,
    artist_name varchar(500), --Need to Change Length Later
    PRIMARY KEY (artist_id)
);

CREATE TABLE searchengine.songs(
    song_id int,
    artist_id int,
    song_name varchar(500), --Need to Change Length Later
    url_suffix varchar(500), --Need to Change Length Later
    PRIMARY KEY(song_id),
    FOREIGN KEY (artist_id) REFERENCES searchengine.artists (artist_id)
);

CREATE TABLE searchengine.tokens(
    song_id int,
    token varchar(500), --Need to Change Length Later
    token_count smallint,
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id) REFERENCES searchengine.songs (song_id)
);

CREATE TABLE searchengine.TFIDFs(
    song_id int, --Need to Change Length Later
    token varchar(500),
    TFIDF_score real, --Need to Change Length Later
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id, token) REFERENCES searchengine.tokens (song_id, token),
    FOREIGN KEY (song_id) REFERENCES searchengine.songs (song_id)
);