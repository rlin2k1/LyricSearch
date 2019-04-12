DROP TABLE IF EXISTS artists CASCADE;
CREATE TABLE artists(
    artist_id smallint,
    artist_name varchar(500) NOT NULL, --Need to Change Length Later
    PRIMARY KEY (artist_id)
);

DROP TABLE IF EXISTS songs CASCADE;
CREATE TABLE songs(
    song_id int,
    artist_id int,
    song_name varchar(500) NOT NULL, --Need to Change Length Later
    url_suffix varchar(500), --Need to Change Length Later
    PRIMARY KEY(song_id),
    FOREIGN KEY (artist_id) REFERENCES searchengine.artists (artist_id)
);

DROP TABLE IF EXISTS tokens CASCADE;
CREATE TABLE tokens(
    song_id int,
    token varchar(500) NOT NULL, --Need to Change Length Later
    token_count smallint,
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id) REFERENCES searchengine.songs (song_id)
);

DROP TABLE IF EXISTS TFIDFs CASCADE;
CREATE TABLE TFIDFs(
    song_id int, --Need to Change Length Later
    token varchar(500) NOT NULL,
    TFIDF_score real NOT NULL, --Need to Change Length Later
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id, token) REFERENCES searchengine.tokens (song_id, token),
    FOREIGN KEY (song_id) REFERENCES searchengine.songs (song_id)
);