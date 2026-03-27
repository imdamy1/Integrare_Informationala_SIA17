-- Interogarea 1 — număr de piese pe categorie de popularitate
SELECT popularity_category, COUNT(*) AS total_songs
FROM V_MUSIC_ANALYTICS
GROUP BY popularity_category
ORDER BY total_songs DESC;
 
-- Interogarea 2 — total stream-uri pe gen muzical
SELECT genre, SUM(streams) AS total_streams
FROM V_MUSIC_ANALYTICS
GROUP BY genre
ORDER BY total_streams DESC;
 
-- Interogarea 3 — piese de tip TOP HIT pe regiuni
SELECT region, COUNT(*) AS total_top_hits
FROM V_MUSIC_ANALYTICS
WHERE ranking_category = 'TOP HIT'
GROUP BY region
ORDER BY total_top_hits DESC;
 
-- Interogarea 4 — top artiști după stream-uri
SELECT artist, ROUND(SUM(streams), 2) AS total_streams
FROM V_MUSIC_ANALYTICS
GROUP BY artist
ORDER BY total_streams DESC;
 
-- Interogarea 5 — analiză combinată popularitate + rang
SELECT popularity_category, ranking_category, COUNT(*) AS total_entries
FROM V_MUSIC_ANALYTICS
GROUP BY popularity_category, ranking_category
ORDER BY popularity_category, total_entries DESC;
