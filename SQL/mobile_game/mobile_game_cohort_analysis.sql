/*
Mobile Game Player and Level Data and Cohort Analysis
Data from <p><a href="https://www.kaggle.com/datasets/manchvictor/prediction-of-user-loss-in-mobile-games">this link</a></p>
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, EXTRACT, CTE,
GROUP BY, HAVING, ORDER BY, COUNT, AVG, ALIAS, UNION, FLOOR, CAST, CASE.
*/

Step 1: Import

CREATE TABLE users (
  user_id INT
  , level_id INT
  , success INT
  , duration DECIMAL
  , reststep DECIMAL
  , help INT
  , time TIMESTAMP
)

CREATE TABLE levels (
  avg_duration DECIMAL
  , avg_passrate DECIMAL
  , avg_win_duration DECIMAL
  , avg_retrytimes DECIMAL
  , level_id TEXT
)

/*
Remember that PSQL commands are written on one line
Written on multiple lines here for ease of reading
*/

\COPY public.users(user_id, level_id, success, duration, reststep, help, time) FROM '/Users/raws/Downloads/mobile_game_data/level_seq.csv' DELIMITER E'\t' CSV HEADER;

\COPY public.levels(avg_duration, avg_passrate, avg_win_duration, avg_retrytimes, level_id)
FROM '/Users/raws/Downloads/mobile_game_data/level_meta.csv'
DELIMITER E'\t'
CSV HEADER;

Step 2: Cleaning

--Get rows and columns for users
SELECT
	'Number of rows'
	, COUNT(*)
FROM users
UNION
SELECT
	'Number of columns'
	, COUNT(column_name)
FROM information_schema.columns
WHERE table_name='users';

/*
"Number of columns"	7
"Number of rows"	2194351
*/

--Get rows and columns for levels
SELECT
	'Number of rows'
	, COUNT(*)
FROM levels
UNION
SELECT
	'Number of columns'
	, COUNT(column_name)
FROM information_schema.columns
WHERE table_name='levels';

/*
"Number of columns"	5
"Number of rows"	1509
*/

--Check for duplicates
SELECT (users.*)::text, count(*)
FROM users
GROUP BY users.*
HAVING COUNT(*) > 1
ORDER BY 2 DESC

--There are 16,150 duplicate rows, some with as many as 100+ duplicates

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT *
FROM levels
GROUP BY 1, 2, 3, 4, 5
HAVING COUNT(*) > 1) AS levels_dupes

--There are no duplicate rows

--Drop duplicate rows in users (without unique identifier)
DELETE FROM users a
USING users b
WHERE a=b
AND a.ctid < b.ctid;

--Check for Null values
SELECT *
FROM users
WHERE NOT (users IS NOT NULL)

--There are no Null values

Step 3 (For Now): Retention Analysis WIP

with play_start as(select
                  user_id
                  , time
                  , extract(day from time) as day
                from users),
consolidated as (select
                  current_day.day
				          , current_day.user_id as current_day_user
				          , prev_day.user_id as prev_day_user
				         from play_start current_day
				         left join play_start prev_day
				         on current_day.user_id=prev_day.user_id
				         and current_day.day-prev_day.day = 1)

select day
	   , (count(distinct prev_day_user)
		  /count(distinct current_day_user))*100
		  /count(distinct prev_day_user) retention
from consolidated
group by 1

--WIP

with play_start as(select
                  user_id
                  , time
                  , extract(day from time) as day
                from users)
select
                  current_day.day
				          , count(distinct current_day.user_id) as current_day_user
				          , count(distinct prev_day.user_id) as prev_day_user
				         from play_start current_day
				         left join play_start prev_day
				         on current_day.user_id=prev_day.user_id
				         and current_day.day-prev_day.day = 1
						 group by 1

/*
Begin Cohort Analysis


*/
