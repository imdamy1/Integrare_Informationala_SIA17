CREATE OR REPLACE VIEW V_SPOTIFY AS
SELECT
    track_id,
    track_name,
    artist_name,
    genre,
    popularity
FROM spotify_tracks_oracle;

SELECT *
FROM V_SPOTIFY
WHERE ROWNUM <= 5;
