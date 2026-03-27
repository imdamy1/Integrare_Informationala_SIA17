CREATE TABLE spotify_tracks_pg (
    track_id TEXT,
    track_name TEXT,
    artist_name TEXT,
    genre TEXT,
    popularity INT
);

COPY spotify_tracks_pg(track_id, track_name, artist_name, genre, popularity)
FROM 'D:/Damian - FACULTATE/MASTER 2/SEM 2/STRIMBEI/SpotifyFeatures.csv'
DELIMITER ';'
CSV HEADER;

SELECT * FROM spotify_tracks_pg LIMIT 10;

SELECT COUNT(*) 
FROM spotify_tracks_pg;

SELECT *
FROM spotify_tracks_pg
WHERE track_id IS NULL
   OR track_name IS NULL
   OR artist_name IS NULL;


   SELECT COUNT(*)
FROM spotify_tracks_pg;

SELECT COUNT(DISTINCT track_id)
FROM spotify_tracks_pg;

DELETE FROM spotify_tracks_pg
WHERE track_id IS NULL
   OR track_name IS NULL
   OR artist_name IS NULL;

   SELECT COUNT(*) FROM spotify_tracks_pg;


   SELECT *
FROM spotify_tracks_pg
WHERE track_id IS NULL
   OR track_name IS NULL
   OR artist_name IS NULL;


   SELECT track_id, COUNT(*)
FROM spotify_tracks_pg
GROUP BY track_id
HAVING COUNT(*) > 1;


SELECT track_name, artist_name, COUNT(*)
FROM spotify_tracks_pg
GROUP BY track_name, artist_name
HAVING COUNT(*) > 1;

DELETE FROM spotify_tracks_pg a
USING spotify_tracks_pg b
WHERE a.ctid < b.ctid
AND a.track_id = b.track_id;

SELECT track_id, COUNT(*)
FROM spotify_tracks_pg
GROUP BY track_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) 
FROM spotify_tracks_pg;

SELECT * 
FROM spotify_tracks_pg
LIMIT 10;

SELECT DISTINCT genre
FROM spotify_tracks_pg
LIMIT 20;

UPDATE spotify_tracks_pg
SET genre = 'Unknown'
WHERE genre IS NULL;
