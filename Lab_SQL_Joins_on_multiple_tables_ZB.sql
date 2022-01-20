-- Lab | SQL Joins on multiple tables
-- Zsanett Borsos

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT sakila.store.store_id, sakila.city.city, sakila.country.country FROM sakila.store
JOIN sakila.address ON
sakila.store.address_id = sakila.address.address_id
JOIN sakila.city ON
sakila.address.city_id = sakila.city.city_id
JOIN sakila.country ON
sakila.city.country_id = sakila.country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT sakila.store.store_id, SUM(sakila.payment.amount) AS 'Business' FROM sakila.store
JOIN sakila.staff ON
sakila.store.store_id = sakila.staff.store_id
JOIN sakila.payment ON
sakila.staff.staff_id = sakila.payment.staff_id
GROUP BY sakila.store.store_id;

-- 3. What is the average running time of films by category?
SELECT sakila.category.name AS 'Film category', AVG(sakila.film.length) AS 'Average running time' FROM sakila.film
JOIN sakila.film_category ON
sakila.film.film_id = sakila.film_category.film_id
JOIN sakila.category ON
sakila.film_category.category_id = sakila.category.category_id
GROUP BY sakila.category.name;

-- 4. Which film categories are longest?
SELECT sakila.category.name AS 'Film category', ROUND(AVG(sakila.film.length)) AS 'Average running time' FROM sakila.film
JOIN sakila.film_category ON
sakila.film.film_id = sakila.film_category.film_id
JOIN sakila.category ON
sakila.film_category.category_id = sakila.category.category_id
GROUP BY sakila.category.name
ORDER BY AVG(sakila.film.length) DESC;

-- Display the most frequently rented movies in descending order.
SELECT sakila.film.title, COUNT(sakila.rental.inventory_id) AS 'Number of times movie was rented' FROM sakila.rental
JOIN sakila.inventory ON
sakila.rental.inventory_id = sakila.inventory.inventory_id
JOIN sakila.film ON
sakila.inventory.film_id = sakila.film.film_id
GROUP BY sakila.film.title
ORDER BY COUNT(sakila.rental.inventory_id) DESC;

-- List the top five genres in gross revenue in descending order.
SELECT sakila.category.name, ROUND(SUM(sakila.payment.amount)) AS 'Gross revenue' 
FROM sakila.category
JOIN sakila.film_category ON
sakila.category.category_id = sakila.film_category.category_id
JOIN sakila.inventory ON
sakila.film_category.film_id = sakila.inventory.film_id
JOIN sakila.rental ON
sakila.inventory.inventory_id = sakila.rental.inventory_id
JOIN sakila.payment ON
sakila.rental.rental_id = sakila.payment.rental_id
GROUP BY sakila.category.name
ORDER BY ROUND(SUM(sakila.payment.amount)) DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT sakila.inventory.store_id, sakila.film.title, COUNT(sakila.film.film_id) AS 'Number of copies available' FROM sakila.film
JOIN sakila.inventory ON
sakila.film.film_id = sakila.inventory.film_id
WHERE sakila.film.title IN('ACADEMY DINOSAUR') AND sakila.inventory.store_id = 1
GROUP BY sakila.inventory.store_id;

