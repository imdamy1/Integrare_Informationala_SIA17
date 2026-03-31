CREATE TABLE billboard_csv (
    chart_date   VARCHAR2(30),
    rank_no      NUMBER,
    song         VARCHAR2(300),
    artist       VARCHAR2(300)
);

CREATE TABLE spotify_tracks_oracle (
    track_id      VARCHAR2(100),
    track_name    VARCHAR2(300),
    artist_name   VARCHAR2(300),
    genre         VARCHAR2(150),
    popularity    NUMBER
);
