CREATE OR REPLACE VIEW V_BILLBOARD AS
SELECT
    chart_date,
    rank_no,
    song,
    artist
FROM billboard_csv;

SELECT *
FROM V_BILLBOARD
WHERE ROWNUM <= 5;
