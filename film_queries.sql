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
SELECT last_name, COUNT(*) FROM actor 
GROUP BY last_name;

--4b
 SELECT last_name, COUNT(*) as count FROM actor 
 GROUP BY last_name 
 HAVING count > 1;

 --4c
SELECT * FROM actor 
WHERE last_name LIKE 'Williams';

UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

--5a
SHOW CREATE TABLE address;

--6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address
ON staff.address_id = address.address_id;

--6b
SELECT staff.first_name, staff.last_name, SUM(payment.amount)
FROM staff 
JOIN payment ON staff.staff_id = payment.staff_id
WHERE YEAR(payment.payment_date) = 2005 AND MONTH(payment.payment_date) = 8
GROUP BY 1, 2;

--6c
SELECT film.title, COUNT(film_actor.actor_id) 
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY 1;

--6d
SELECT film.title, COUNT(inventory.inventory_id) 
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title LIKE "Hunchback Impossible"
GROUP BY 1;

--6e
SELECT p.customer_id, SUM(p.amount), c.first_name, c.last_name
    FROM payment p
    JOIN customer c ON c.customer_id = p.customer_id
    GROUP BY 1, 3, 4
    ORDER BY 4;

--7a
SELECT title FROM film 
WHERE language_id IN
    (SELECT language_id
        FROM language 
        WHERE name = "English")
AND (title LIKE "K%" OR title LIKE "Q%");

-- 7b. 
SELECT first_name, last_name FROM actor
WHERE actor_id IN 
    (SELECT actor_id FROM film_actor 
    WHERE film_id IN
        (SELECT film_id FROM film
        WHERE title = "Alone Trip"));

-- 7c. 
SELECT c.first_name, c.last_name, c.email FROM customer c 
JOIN customer_list cl ON c.customer_id = cl.ID
WHERE cl.country = "Canada";

-- 7d. 
SELECT title FROM film 
WHERE film_id IN
    (SELECT film_id FROM film_category
    WHERE category_id IN
        (SELECT category_id FROM category
        WHERE name = "Family" ));

-- 7e. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(*) FROM film f, inventory i, rental r
WHERE f.film_id = i.film_id 
AND r.inventory_id = i.inventory_id 
GROUP BY i.film_id
ORDER BY 2 DESC;

-- 7f. 
SELECT store, total_sales FROM sales_by_store;

-- 7g. 
SELECT s.store_id, ci.city, co.country FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 7h. 
SELECT name, SUM(p.amount) AS revenue_gross FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 8a. 
CREATE VIEW top_five_genres AS
SELECT name, SUM(p.amount) AS revenue_gross FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 8b. 
SELECT * FROM top_five_genres;

--8c
DROP VIEW top_five_genres;