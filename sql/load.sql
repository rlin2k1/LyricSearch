\copy searchengine.artists FROM '/home/cs143/data/artist.csv' WITH DELIMITER ',' QUOTE '"' CSV;
\copy searchengine.songs FROM '/home/cs143/data/song.csv' WITH DELIMITER ',' QUOTE '"' CSV;
\copy searchengine.tokens FROM '/home/cs143/data/token.csv' WITH DELIMITER ',' QUOTE '"' CSV;