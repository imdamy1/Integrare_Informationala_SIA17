CREATE OR REPLACE VIEW OLAP_STREAMS_BY_REGION AS
SELECT
    region,
    COUNT(*) AS total_entries,
    SUM(streams) AS total_streams,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM FACT_MUSIC
GROUP BY region;
 
CREATE OR REPLACE VIEW OLAP_GENRE_ANALYSIS AS
SELECT
    genre,
    COUNT(*) AS total_songs,
    ROUND(AVG(rank_no), 2) AS avg_rank,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM FACT_MUSIC
GROUP BY genre;
 
CREATE OR REPLACE VIEW OLAP_GENRE_ANALYSIS AS
SELECT
    genre,
    COUNT(*) AS total_songs,
    ROUND(AVG(rank_no), 2) AS avg_rank,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM FACT_MUSIC
GROUP BY genre;
 
