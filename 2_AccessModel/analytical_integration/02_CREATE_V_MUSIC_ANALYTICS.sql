CREATE OR REPLACE VIEW V_MUSIC_ANALYTICS AS
SELECT
    song,
    artist,
    rank_no,
    chart_date,
    genre,
    popularity,
    region,
    streams,
 
    -- clasificare popularitate
    CASE
        WHEN popularity >= 80 THEN 'HIGH'
        WHEN popularity >= 50 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS popularity_category,
 
    -- clasificare performanta in top
    CASE
        WHEN rank_no <= 10 THEN 'TOP HIT'
        WHEN rank_no <= 50 THEN 'MID HIT'
        ELSE 'LOW RANK'
    END AS ranking_category,
 
    -- clasificare stream-uri
    CASE
        WHEN streams >= 1000000 THEN 'VIRAL'
        WHEN streams >= 100000 THEN 'TRENDING'
        ELSE 'NORMAL'
    END AS stream_category
 
FROM V_MUSIC_INTEGRATION;
