COPY mental_health (
    inter_dom,
    japanese_cate, 
    english_cate,
    academic,
    age,
    stay, 
    todep,
    tosc,
    toas
)
FROM '/mnt/c/Users/kyoto/OneDrive/Documents/Student_mental_health/mental_health_data.csv'
WITH CSV HEADER;

