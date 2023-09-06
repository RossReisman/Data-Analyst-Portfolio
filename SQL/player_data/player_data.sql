Player Data Cleaning and Analysis
Data randomly generated
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, AND, OR, NOT, IS,
NULL, INTERVAL, LIKE/NOT LIKE, MIN/MAX, DISTINCT, BETWEEN, GROUP BY, HAVING,
ORDER BY, COUNT, AVG, ALIAS, LIMIT, UNION, FLOOR.


Step 1: Create Tables

CREATE TABLE login (
	user_id TEXT,
	event_timestamp TIMESTAMP
)

CREATE TABLE logout (
	user_id TEXT,
	event_timestamp TIMESTAMP
)

CREATE TABLE damage (
	user_id TEXT,
	event_timestamp TIMESTAMP,
	damage_taken INT
)
