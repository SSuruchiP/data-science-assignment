----- Question 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie rental company. The management team is looking to improve decision-making by analyzing existing customer, rental, and inventory data
CREATE DATABASE Sakila;
USE Sakila;
DESCRIBE customer;
SELECT 
    c.first_name,
    c.last_name,
    c.email,
    SUM(p.amount) AS total_amount_spent
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email
ORDER BY 
    total_amount_spent DESC
LIMIT 5;
SELECT 
    cat.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM category cat
JOIN film_category fc 
    ON cat.category_id = fc.category_id
JOIN inventory i 
    ON fc.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY 
    cat.category_id, cat.name
ORDER BY 
    rental_count DESC
LIMIT 3;

SELECT 
    s.store_id,
    COUNT(i.inventory_id) AS total_films,
    COUNT(CASE 
              WHEN r.rental_id IS NULL THEN 1 
          END) AS never_rented_films
FROM store s
JOIN inventory i 
    ON s.store_id = i.store_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY 
    s.store_id;
    
    SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY 
    DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY 
    month;
    
    SELECT 
    c.first_name,
    c.last_name,
    c.email,
    COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r 
    ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email
HAVING 
    COUNT(r.rental_id) > 10;