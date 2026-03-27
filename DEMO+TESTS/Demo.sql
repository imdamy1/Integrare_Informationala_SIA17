-- DEMO PROIECT: Sistem federat de analiză a popularității muzicale

-- USER: SYSTEM / schema proiect
--
-- Surse integrate:
--   DS_1 -> Billboard CSV / billboard_csv
--   DS_2 -> Spotify SQL / spotify_tracks_oracle
--   DS_3 -> MongoDB / mongo_rankings

-- 1. DATA SOURCE VIEWS

-- Billboard source
SELECT * 
FROM V_BILLBOARD
FETCH FIRST 5 ROWS ONLY;
 
-- Spotify source
SELECT * 
FROM V_SPOTIFY
FETCH FIRST 5 ROWS ONLY;
 
-- Mongo source
SELECT * 
FROM V_MONGO
FETCH FIRST 5 ROWS ONLY;
 
-- 2. INTEGRATION VIEW

-- View-ul central care unește cele 3 surse prin song / track_name
SELECT *
FROM V_MUSIC_INTEGRATION
FETCH FIRST 10 ROWS ONLY;
 
-- Verificare consistență integrare
SELECT
    COUNT(*) AS total_rows,
    COUNT(genre) AS rows_with_spotify,
    COUNT(region) AS rows_with_region
FROM V_MUSIC_INTEGRATION;
 
-- Verificare cazuri incomplete
SELECT *
FROM V_MUSIC_INTEGRATION
WHERE genre IS NULL
   OR streams IS NULL
FETCH FIRST 10 ROWS ONLY;
 
-- 3. DIMENSIONAL VIEWS
 
-- D1: Dimensiune piese
SELECT *
FROM DIM_SONGS
FETCH FIRST 10 ROWS ONLY;
 
-- Verificare duplicate în DIM_SONGS
SELECT song, COUNT(*) AS cnt
FROM DIM_SONGS
GROUP BY song
HAVING COUNT(*) > 1;
 
-- D2: Dimensiune regiuni
SELECT *
FROM DIM_REGION
FETCH FIRST 10 ROWS ONLY;
 
-- Verificare regiuni distincte
SELECT region, COUNT(*) AS total_rows
FROM V_MUSIC_INTEGRATION
GROUP BY region
ORDER BY total_rows DESC;
 
-- D3: Dimensiune timp
SELECT *
FROM DIM_TIME
ORDER BY chart_date
FETCH FIRST 10 ROWS ONLY;
 
-- D4: Dimensiune popularitate
SELECT *
FROM DIM_POPULARITY
FETCH FIRST 10 ROWS ONLY;
 
-- Distribuție categorii popularitate
SELECT popularity_category, COUNT(*) AS total_rows
FROM DIM_POPULARITY
GROUP BY popularity_category
ORDER BY total_rows DESC;
 
-- 4. FACT VIEW
 
-- Fact principal pentru modelul analitic
SELECT *
FROM FACT_MUSIC
FETCH FIRST 10 ROWS ONLY;
 
-- Verificare volum total
SELECT COUNT(*) AS total_rows
FROM FACT_MUSIC;
 
-- Indicatori sintetici
SELECT
    COUNT(*) AS total_entries,
    ROUND(AVG(popularity), 2) AS avg_popularity,
    SUM(streams) AS total_streams
FROM FACT_MUSIC;
 
-- 5. ANALYTICAL / OLAP VIEWS
 
-- OLAP 1: Streams by Region
SELECT *
FROM OLAP_STREAMS_BY_REGION
ORDER BY total_streams DESC;
 
-- Verificare total entries
SELECT SUM(total_entries) AS total_entries_check
FROM OLAP_STREAMS_BY_REGION;
 
-- OLAP 2: Genre Analysis
SELECT *
FROM OLAP_GENRE_ANALYSIS
ORDER BY avg_popularity DESC;
 
-- Verificare genuri distincte
SELECT COUNT(DISTINCT genre) AS distinct_genres
FROM V_MUSIC_INTEGRATION;
 
-- OLAP 3: Rank Analysis
SELECT *
FROM OLAP_RANK_ANALYSIS
ORDER BY rank_no;
 
-- Verificare ranguri distincte
SELECT COUNT(DISTINCT rank_no) AS distinct_ranks
FROM FACT_MUSIC;
 
-- 6. COMPLEX ANALYTICAL QUERIES
 
-- Q1. Top 10 artiști după total streams
SELECT
    artist,
    COUNT(DISTINCT song) AS total_songs,
    ROUND(AVG(popularity), 2) AS avg_popularity,
    SUM(streams) AS total_streams
FROM V_MUSIC_INTEGRATION
GROUP BY artist
ORDER BY total_streams DESC
FETCH FIRST 10 ROWS ONLY;
 
-- Q2. Analiza genurilor după popularitate și poziție în top
SELECT
    genre,
    COUNT(*) AS total_songs,
    ROUND(AVG(rank_no), 2) AS avg_rank,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM V_MUSIC_INTEGRATION
GROUP BY genre
ORDER BY avg_popularity DESC, avg_rank ASC;
 
-- Q3. Regiuni cu cel mai mare volum de stream-uri
SELECT
    region,
    COUNT(DISTINCT song) AS total_songs,
    SUM(streams) AS total_streams,
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM V_MUSIC_INTEGRATION
GROUP BY region
ORDER BY total_streams DESC;
 
-- Q4. Top piese din Billboard cu cea mai mare popularitate Spotify
SELECT
    song,
    artist,
    rank_no,
    genre,
    popularity
FROM V_MUSIC_INTEGRATION
WHERE rank_no <= 10
ORDER BY popularity DESC, rank_no ASC;
 
-- Q5. Distribuția pieselor pe categorii de popularitate
SELECT
    CASE
        WHEN popularity >= 80 THEN 'HIGH'
        WHEN popularity >= 50 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS popularity_category,
    COUNT(*) AS total_songs,
    SUM(streams) AS total_streams
FROM FACT_MUSIC
GROUP BY
    CASE
        WHEN popularity >= 80 THEN 'HIGH'
        WHEN popularity >= 50 THEN 'MEDIUM'
        ELSE 'LOW'
    END
ORDER BY total_streams DESC;
 
-- Q6. Raport ierarhic de tip ROLLUP: regiune x gen
SELECT
    CASE
        WHEN GROUPING(region) = 1 THEN '{TOTAL GENERAL}'
        ELSE region
    END AS region_label,
    CASE
        WHEN GROUPING(region) = 1 THEN ' '
        WHEN GROUPING(genre) = 1 THEN 'subtotal ' || region
        ELSE genre
    END AS genre_label,
    COUNT(*) AS total_entries,
    SUM(streams) AS total_streams
FROM V_MUSIC_INTEGRATION
GROUP BY ROLLUP(region, genre)
ORDER BY region, genre;
