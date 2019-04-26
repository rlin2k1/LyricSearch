-- Load TF-IDF scores into tfidf table
INSERT INTO tfidf
SELECT
  song_id,
  token,
  (tf * log(j/df::float)) AS score
FROM (
  -- Lay out necessary values (TF, DF, J) for each song-token pair
  SELECT
    song_id,
    token,
    count AS tf,
    df,
    -- Find J (# songs)
    (SELECT COUNT(*) FROM (SELECT DISTINCT song_id FROM song) songs) AS j
  FROM token
  NATURAL JOIN (
    -- Get document frequency for each token
    SELECT
      token,
      COUNT(*) AS df
    FROM token
    GROUP BY token
  ) token_df
) token_tf_df_j;