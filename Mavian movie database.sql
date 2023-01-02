use mavenmovies;

select *
from rental

select customer_id, return_date
from rental

select first_name, last_name, email
from customer

select distinct rental_duration
from film

-- write a query to get all payments for first 100 customers
select * 
from payment
where customer_id < 101

-- write a query to get just payments over 5$ for those same customers(first 100) since january 1 2006.
select customer_id, rental_id, amount, payment_date
from payment
where customer_id < 101
	and amount >= 5
    and payment_date > '2006-01-01'
    
-- write a query to pull all payments from those specific customers,along with payments over 5$, from any customer.
select customer_id, rental_id, amount, payment_date
from payment
where amount > 5 
      AND customer_id = 73
		OR customer_id = 42
        OR  customer_id = 53
        OR customer_id = 60
        
-- write a query to pull a list of films which include a Behind The Scenes special feature.
SELECT title, special_features
from film
where 
special_features LIKE '%Behind The Scenes%'

-- write a query of pull a count of titles sliced by rental duration.
select rental_duration,
       COUNT(title) as films_with_this_rental_duration
FROM film
GROUP BY rental_duration

-- write a query to count of films,along with the average,min,and maxrental date,grouped by replacement cost.
SELECT replacement_cost,
       COUNT(film_id) AS number_of_films,
       MIN(rental_rate) AS cheapest_rental,
       MAX(rental_rate) AS most_expensive_rental,
       AVG(rental_rate) AS average_rental
FROM film
GROUP BY replacement_cost

-- write a query to get a list of customer_ids with less then 15 rentals all-time.
SELECT
  customer_id,
  COUNT(*) AS total_rentals
  FROM rental
  GROUP BY customer_id
  HAVING COUNT(*) < 15
  
  -- write a query to get a list of first and last names of all customers,and label then as either,
  -- 'store1 active','store1 inactive','store2 active', or 'store2 inactive'?
  SELECT 
  first_name,
  last_name,
  CASE
     WHEN store_id=1 AND active=1 THEN 'store1 active'
     WHEN store_id=1 AND active=0 THEN 'store1 inactive'
     WHEN store_id=2 AND active=1 THEN 'store2 active'
     WHEN store_id=2 AND active=0 THEN 'store2 inactive'
     ELSE 'oops..check logic'
END as store_and_status
FROM customer

-- write a query to create a table to count number of customers broken down by store_id(in rows) and active status in column.
SELECT 
   store_id,
   COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS ACTIVE,
   COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS INACTIVE
FROM customer
GROUP BY
	Store_id
    
-- write a query to get a list of each film in inventory.
SELECT DISTINCT
       inventory.inventory_id,
       inventory.store_id,
       film.title,
       film.description
FROM film
     INNER JOIN inventory
        ON film.film_id = inventory.film_id
        
-- write a query to get a list of all titles and figure out
-- how many actors are associated with each title.

select 
  film.title,
  COUNT(film_actor.actor_id) AS numbers_of_actors
FROM film
     LEFT JOIN film_actor
     ON film.film_id = film_actor.film_id
GROUP BY
   film.title
   
-- Write a query to get a list of all actors with each title that they appear in.
SELECT
  film.title,
  actor.first_name,
  actor.last_name
FROM actor
     INNER JOIN film_actor
       ON actor.actor_id = film_actor.actor_id
	INNER JOIN film
       ON film_actor.film_id = film.film_id
ORDER BY
  actor.last_name,
  actor.first_name
    
