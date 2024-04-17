CREATE TABLE mental_health (
    ID  SERIAL PRIMARY KEY,
    inter_dom   VARCHAR,
    japanese_cate   VARCHAR, 
    english_cate    VARCHAR,
    academic    VARCHAR,
    age     NUMERIC,
    stay    NUMERIC, 
    todep   NUMERIC,
    tosc    NUMERIC,
    toas    NUMERIC
);