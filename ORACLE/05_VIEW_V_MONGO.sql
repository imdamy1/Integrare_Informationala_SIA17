CREATE OR REPLACE VIEW V_MONGO AS
SELECT jt.*
FROM JSON_TABLE(
       get_restheart_data_media(
         'http://localhost:8081/music_db/daily_rankings',
         'admin:secret'
       ),
       '$[*]'
       COLUMNS (
         track_name   VARCHAR2(300) PATH '$.track_name',
         artist       VARCHAR2(300) PATH '$.artist',
         streams      NUMBER        PATH '$.streams',
         region       VARCHAR2(100) PATH '$.region',
         date_str     VARCHAR2(50)  PATH '$.date'
       )
     ) jt;

SELECT *
FROM V_MONGO
WHERE ROWNUM <= 5;
