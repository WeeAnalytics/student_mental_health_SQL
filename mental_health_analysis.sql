-- Number and Percentage of international vs domestic students 

SELECT inter_dom,
       COUNT(*) AS count, 
       ROUND(COUNT(*)/SUM(COUNT(*)) OVER(),2) AS percent
FROM mental_health
GROUP BY inter_dom;

--Create a view that includes new column depression_level and stay_length
CREATE VIEW depression_state AS 
    SELECT 
        *,
        CASE
             WHEN todep>19 THEN'Severe Depression'
             WHEN todep BETWEEN 15 AND 19 THEN 'Moderately severe'
              WHEN todep BETWEEN 10 AND 14 THEN 'Moderate'
              WHEN todep BETWEEN 5 AND 9 THEN 'Mild'
             ELSE 'No depression'
        END  AS depression_state,
        CASE    
            WHEN stay BETWEEN 1 AND 3 THEN 'short'
            WHEN stay BETWEEN 4 AND 7 THEN 'medium'
            ELSE 'long'
        END AS stay_length

    FROM mental_health;

-- Undergrads with short stay_length are more likely to be severely depressed or moderately severely depressed
SELECT 
    inter_dom, 
    japanese_cate,
    english_cate,
    academic,
    depression_state,
    stay_length,
FROM depression_state
WHERE depression_State = 'Severe Depression' OR
      depression_state = 'Moderately severe';

-- -depression_level percentage based on the level of Japanese proficiency amongst International students

SELECT DISTINCT
    japanese_cate,
    academic,
    depression_state,
    ROUND((CAST(COUNT(*) OVER (PARTITION BY japanese_cate, depression_state)AS FLOAT)/
    COUNT(japanese_cate) OVER (PARTITION BY japanese_cate))::NUMERIC, 2) AS percent

FROM depression_state
WHERE inter_dom = 'Inter'
ORDER BY japanese_cate,academic,depression_state DESC;


--depression_level percentage based on the level of Japanese proficiency amongst Japanese students

SELECT DISTINCT
    japanese_cate,
    academic,
    depression_state,
    ROUND((CAST(COUNT(*) OVER (PARTITION BY japanese_cate, depression_state)AS FLOAT)/
    COUNT(japanese_cate) OVER (PARTITION BY japanese_cate))::NUMERIC, 2) AS percent

FROM depression_state
WHERE inter_dom = 'Dom'
ORDER BY japanese_cate,academic,depression_state DESC;

--depression_level percentage based on the level of English proficiency amongst International students

SELECT DISTINCT
    english_cate,
    academic,
    depression_state,
    ROUND((CAST(COUNT(*) OVER (PARTITION BY english_cate, depression_state)AS FLOAT)/
    COUNT(english_cate) OVER (PARTITION BY english_cate))::NUMERIC, 2) AS percent

FROM depression_state
WHERE inter_dom = 'Inter'
ORDER BY english_cate,academic,depression_state DESC;

--depression_level percentage based on the level of English proficiency amongst Japanese students

SELECT DISTINCT
    english_cate,
    academic,
    depression_state,
    ROUND((CAST(COUNT(*) OVER (PARTITION BY english_cate, depression_state)AS FLOAT)/
    COUNT(english_cate) OVER (PARTITION BY english_cate))::NUMERIC, 2) AS percent

FROM depression_state
WHERE inter_dom = 'Dom'
ORDER BY english_cate,academic,depression_state DESC;

-- depression_level percentage based on length of stay [ 1-3 years (short), 4-7 years (medium), 8-10 years (long)]
 SELECT DISTINCT
    stay_length,
    academic,
    depression_state,
    inter_dom,
    ROUND((CAST(COUNT(*) OVER (PARTITION BY stay_length, depression_state)AS FLOAT)/
    COUNT(stay_length) OVER (PARTITION BY stay_length))::NUMERIC, 2) AS percent

FROM depression_state
ORDER BY stay_length,academic,depression_state,inter_dom DESC;

--difference between the average tosc of severly depressed and moderately severe vs other studentss

WITH 
less_depressed AS
 (SELECT AVG(tosc) AS ave_tosc_lessdepressed
  FROM depression_state
  WHERE depression_state <> 'Moderately severe' OR
        depression_state <> 'Severe Depression')

SELECT inter_dom,academic,depression_state, tosc - ave_tosc_lessdepressed AS diff_tosc
FROM depression_state,less_depressed
WHERE depression_state = 'Severe Depression' OR
      depression_state = 'Moderately severe';
 

-- difference between the average toas
WITH 
less_depressed_toas AS
 (SELECT AVG(toas) AS ave_toas_lessdepressed
  FROM depression_state
  WHERE depression_state <> 'Moderately severe' OR
        depression_state <> 'Severe Depression')

SELECT inter_dom,academic,depression_state, toas - ave_toas_lessdepressed AS diff_toas
FROM depression_state,less_depressed_toas
WHERE depression_state = 'Severe Depression' OR
      depression_state = 'Moderately severe';