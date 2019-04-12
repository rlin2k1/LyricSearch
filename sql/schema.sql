DROP TABLE IF EXISTS artists CASCADE;
CREATE TABLE artists(
    artist_id smallint NOT NULL,
    artist_name varchar(500) NOT NULL, --Need to Change Length Later
    PRIMARY KEY (artist_id)
);

DROP TABLE IF EXISTS songs CASCADE;
CREATE TABLE songs(
    song_id int NOT NULL,
    artist_id int NOT NULL,
    song_name varchar(500) NOT NULL, --Need to Change Length Later
    url_suffix varchar(500) NOT NULL, --Need to Change Length Later
    PRIMARY KEY(song_id),
    FOREIGN KEY (artist_id) REFERENCES artists (artist_id)
);

DROP TABLE IF EXISTS tokens CASCADE;
CREATE TABLE tokens(
    song_id int NOT NULL,
    token varchar(500) NOT NULL, --Need to Change Length Later
    token_count smallint NOT NULL,
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id) REFERENCES songs (song_id)
);

DROP TABLE IF EXISTS TFIDFs CASCADE;
CREATE TABLE TFIDFs(
    song_id int NOT NULL, --Need to Change Length Later
    token varchar(500) NOT NULL,
    TFIDF_score real NOT NULL, --Need to Change Length Later
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id, token) REFERENCES tokens (song_id, token),
    FOREIGN KEY (song_id) REFERENCES songs (song_id)
);