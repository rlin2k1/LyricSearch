DROP TABLE IF EXISTS artists CASCADE;
CREATE TABLE artists (
    artist_id smallint NOT NULL,
    artist_name varchar(44) NOT NULL,
    PRIMARY KEY (artist_id)
);

DROP TABLE IF EXISTS songs CASCADE;
CREATE TABLE songs (
    song_id int NOT NULL,
    artist_id smallint NOT NULL,
    song_name varchar(77) NOT NULL,
    url_suffix varchar(102) NOT NULL,
    PRIMARY KEY(song_id),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

DROP TABLE IF EXISTS tokens CASCADE;
CREATE TABLE tokens (
    song_id int NOT NULL,
    token varchar(106) NOT NULL,
    token_count smallint NOT NULL,
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

DROP TABLE IF EXISTS TFIDF_scores CASCADE;
CREATE TABLE TFIDF_scores (
    song_id int NOT NULL,
    token varchar(106) NOT NULL,
    TFIDF_score real NOT NULL, --TODO: Verify that this is the right type.
    PRIMARY KEY (song_id, token),
    FOREIGN KEY (song_id, token) REFERENCES tokens(song_id, token),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);