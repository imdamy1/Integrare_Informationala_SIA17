CREATE OR REPLACE VIEW V_MUSIC_INTEGRATION AS
SELECT
    b.song,
    b.artist,
    b.rank_no,
    b.chart_date,
    s.genre,
    s.popularity,
    m.region,
    m.streams
FROM V_BILLBOARD b
LEFT JOIN V_SPOTIFY s
    ON LOWER(TRIM(b.song)) = LOWER(TRIM(s.track_name))
LEFT JOIN V_MONGO m
    ON LOWER(TRIM(b.song)) = LOWER(TRIM(m.track_name));
 
SELECT *
FROM V_MUSIC_INTEGRATION
WHERE ROWNUM <= 5;
