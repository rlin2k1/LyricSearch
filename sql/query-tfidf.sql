-- Serve the OR query: Get songs and their TF-IDF score sums
SELECT song_name, artist_name, page_link
FROM song
NATURAL JOIN artist
NATURAL JOIN (
  -- Get songs that have at least one token in the search query
  SELECT song_id, SUM(score) AS score_sum
  FROM tfidf
  WHERE token IN ('deep', 'though') -- TODO: REPLACE THIS WITH WORDS IN QUERY!
  GROUP BY song_id
  -- ORDER BY score_sum DESC; -- TODO: REMOVE THIS IF EVERYTHING IS OKAY.
) score_sums
ORDER BY score_sum DESC; -- TODO: THIS IS WEIRD.


-- Serve the AND query: Get songs and their TF-IDF score sums
SELECT song_name, artist_name, page_link
FROM song
NATURAL JOIN artist
NATURAL JOIN (
  -- Get songs that have all the tokens in the search query
  SELECT song_id, SUM(score) AS score_sum
  FROM (
    -- Get all song-token pairs whose token is in the search query
    SELECT *
    FROM tfidf
    WHERE token in ('deep', 'though', 'tears', 'got') -- TODO: REPLACE THIS WITH WORDS IN QUERY!
  ) filtered_tokens
  GROUP BY song_id
  HAVING COUNT(*) = 4 -- TODO: REPLACE THIS WITH NUMBER OF WORDS IN QUERY!
  -- ORDER BY score_sum DESC; -- TODO: REMOVE THIS IF EVERYTHING IS OKAY.
) score_sums
ORDER BY score_sum DESC; -- TODO: THIS IS WEIRD.