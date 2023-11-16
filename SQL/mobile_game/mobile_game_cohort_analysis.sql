/*
Mobile Game Player and Level Data and Cohort Analysis
Data from <p><a href="https://www.kaggle.com/datasets/manchvictor/prediction-of-user-loss-in-mobile-games">this link</a></p>
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, EXTRACT, CTE,
GROUP BY, HAVING, ORDER BY, COUNT, AVG, ALIAS, UNION, FLOOR, CAST, CASE.
*/

CREATE TABLE users (
  user_id TEXT
  , level_id TEXT
  , success INT
  , duration DECIMAL
  , reststep DECIMAL
  , help INT
  , time TIMESTAMP
)

CREATE TABLE levels (
  level_id TEXT
  , avg_duration DECIMAL
  , avg_passrate DECIMAL
  , avg_win_duration DECIMAL
  , avg_retrytimes DECIMAL
)

/*
Remember that PSQL commands are written on one line
Written on multiple lines here for ease of reading
*/

\COPY public.users(user_id, level_id, success, duration, reststep, help, time)
FROM '/Users/raws/Downloads/mobile_game_data/level_seq.csv'
DELIMITER E'\t'
CSV HEADER;

\COPY public.levels(level_id, avg_duration, avg_passrate, avg_win_duration, avg_retrytimes)
FROM '/Users/raws/Downloads/mobile_game_data/level_meta.csv'
DELIMITER E'\t'
CSV HEADER;
