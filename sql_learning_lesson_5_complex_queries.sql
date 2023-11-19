# Lesson 1
-- Find products that are more
-- expensive than Lettuce (id = 3)
SELECT *
FROM products
WHERE unit_price > (
SELECT unit_price
FROM products
WHERE product_id = 3
);
-- # task 
-- In sql hr database:
-- Find employees whose earn more than average
SELECT * 
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);


-- # Lesson 2 The IN Operator
-- find products that are never orderred

SELECT * 
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
);

-- # task 
-- Find clients without invoices
USE sql_invoicing;

SELECT * 
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
	FROM invoices
);

-- # Lesson 4 Subqueries vs Joins

-- Find clients without invoices - using JOIN

SELECT * 
FROM clients c
LEFT JOIN invoices i USING(client_id)
WHERE i.invoice_id IS NULL;

-- # task 
-- Find customers who have ordered lettuce (id = 3)
-- Select customer_id, first_name, last_name
USE sql_store;

SELECT DISTINCT customer_id, first_name, last_name 
FROM customers
JOIN orders o
USING (customer_id)
JOIN order_items oi
USING (order_id) 
WHERE oi.product_id = 3;

SELECT customer_id, first_name, last_name 
FROM customers
WHERE customer_id IN (
	SELECT DISTINCT customer_id
	FROM orders
	JOIN order_items oi
	USING (order_id)
	WHERE product_id = 3
);

-- # Lesson 5 ALL keyword
-- Select invoices larger than all invoices of
-- client 3

-- USE sql_invoicing;

SELECT MAX(invoice_total) 
FROM invoices
WHERE client_id = 3;

SELECT * 
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total) 
	FROM invoices
	WHERE client_id = 3
);

SELECT * 
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
);


-- # task 

-- # Lesson 6 ANY Keyword
SELECT * 
FROM invoices
WHERE invoice_total > ANY ( -- any of the items in list
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
);

-- Select clients with at least two invoices

-- SELECT client_id, COUNT(*)
-- FROM invoices
-- GROUP BY client_id
-- HAVING COUNT(*) >= 2;

SELECT * 
FROM clients 
WHERE client_id IN (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);

SELECT * 
FROM clients 
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);

-- # task 

-- # Lesson 7 Correlate subqueries 

-- Select employees whose salary is
-- above the average in their office
USE sql_hr;

SELECT AVG(salary), office_id
	FROM employees
    GROUP BY office_id;

SELECT * 
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
    WHERE office_id = e.office_id
);

-- # task 

-- Get invoices that are larger than the 
-- client's average invoice amount

USE sql_invoicing;

SELECT  client_id, AVG(invoice_total)
FROM invoices
GROUP BY client_id;

SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices
	WHERE client_id = i.client_id
); 

-- # Lesson 8 The Exists operator
-- Select clients that have an invoice
SELECT *
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
);

SELECT DISTINCT c.client_id, c.name, c.address, c.city, c.state, c.phone
FROM clients c
JOIN invoices i
USING (client_id);

SELECT * 
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
);


-- # task 
-- Find the products that have never been ordered
USE sql_store;

SELECT * 
FROM products p 
WHERE NOT EXISTS (
	SELECT order_id 
    FROM order_items
    WHERE p.product_id = product_id
);

SELECT * 
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM order_items
);

-- # Lesson 9 Subqueries in SELECT clause
SELECT 
	invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total) FROM invoices) as invoice_average,
    invoice_total - (SELECT invoice_average) as diff
FROM invoices;
	
-- # task 
SELECT DISTINCT
	client_id, 
    c.name,
    (SELECT SUM(invoice_total) FROM invoices WHERE client_id = i.client_id) as total_sales,
    (SELECT AVG(invoice_total) FROM invoices) as invoice_average,
    (SELECT total_sales) - (SELECT - invoice_average) as difference
FROM invoices i
RIGHT JOIN clients c USING(client_id);

SELECT 
	client_id, 
    name, 
    (SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) as total_sales,
    (SELECT AVG(invoice_total) FROM invoices) as invoice_average,
    (SELECT total_sales) - (SELECT - invoice_average) as difference
FROM clients c;

-- # Lesson 10 Subqueries in FROM Clause 
SELECT * 
FROM (
	SELECT 
		client_id, 
		name, 
		(SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) as total_sales,
		(SELECT AVG(invoice_total) FROM invoices) as invoice_average,
		(SELECT total_sales) - (SELECT - invoice_average) as difference
	FROM clients c
) AS sales_summary
-- WHERE total_sales > 800;
WHERE total_sales IS NOT NULL;

-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

-- # Lesson x 
-- # task 

