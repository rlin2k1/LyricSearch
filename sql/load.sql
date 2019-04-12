\copy artists FROM '/home/cs143/data/artist.csv' WITH DELIMITER ',' QUOTE '"' CSV;
\copy songs FROM '/home/cs143/data/song.csv' WITH DELIMITER ',' QUOTE '"' CSV;
\copy tokens FROM '/home/cs143/data/token.csv' WITH DELIMITER ',' QUOTE '"' CSV;