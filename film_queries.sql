-- hw8 film queries
...
--1a 
SELECT first_name, last_name 
FROM actor;

--1b
SELECT UPPER(CONCAT(first_name, last_name)) as Actor_Name 
FROM actor;

--2a
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE first_name 
LIKE 'Joe';

--2b
SELECT first_name, last_name 
FROM actor 
WHERE last_name 
LIKE '%GEN%';

--2c
SELECT first_name, last_name 
FROM actor 
WHERE last_name LIKE '%LI'
ORDER BY last_name, first_name;

--2d
SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

--3a
ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(45) AFTER first_name;

--3b
ALTER TABLE actor
MODIFY COLUMN middle_name blob;

--3b
ALTER TABLE actor
DROP COLUMN middle_name;

--4a
SELECT last_name FROM actor;

--4b
SELECT last_name, COUNT(*) FROM actor 
GROUP BY last_name;

--4c
 SELECT last_name, COUNT(*) as count FROM actor 
 GROUP BY last_name 
 HAVING count > 1;

 --4d
SELECT * FROM actor 
WHERE last_name LIKE 'Williams';

UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;