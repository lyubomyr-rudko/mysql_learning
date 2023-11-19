-- # Lesson 1 Inner Joins
-- USE sql_store;

-- SELECT * 
-- FROM orders
-- JOIN customers ON orders.customer_id = customers.customer_id;

-- SELECT * 
-- FROM orders
-- INNER JOIN customers ON orders.customer_id = customers.customer_id; -- INNER JOIN same as just JOIN

-- SELECT order_id, first_name, last_name, customer_id -- !!!error - need to prefix with table name
-- FROM orders
-- JOIN customers ON orders.customer_id = customers.customer_id;

-- SELECT order_id, first_name, last_name, customers.customer_id
-- FROM orders
-- JOIN customers ON orders.customer_id = customers.customer_id;

-- alias
-- SELECT order_id, first_name, last_name, c.customer_id
-- FROM orders o
-- JOIN customers c
-- ON o.customer_id = c.customer_id;

-- # task 
-- select for each order - order id, product id and its name, and quantity and unit price from order items table 
-- SELECT o.order_id, o.product_id, p.name as product_name, o.quantity, o.unit_price
-- FROM order_items o
-- JOIN products p
-- ON p.product_id = o.product_id;

-- SELECT order_id, p.product_id, name as product_name, quantity, oi.unit_price
-- FROM order_items oi
-- JOIN products p
-- ON p.product_id = oi.product_id;




-- # Lesson 2 Joining across databases
--  USE sql_inventory;

-- SELECT * 
-- FROM sql_store.order_items oi
-- JOIN sql_inventory.products p 
-- ON oi.product_id = p.product_id;

-- USE sql_store;
-- # task 


-- # Lesson 3 SElf joins
-- Employee - to manager relationship - reports_to - tree 

-- write a query to select employee and his manager

-- SELECT e.employee_id, e.first_name, e.last_name, m.first_name as manager_name 
-- FROM sql_hr.employees e
-- JOIN sql_hr.employees m
-- ON e.reports_to = m.employee_id;

Use sql_hr;

-- SELECT * 
-- FROM employees e
-- JOIN employees m
-- ON e.reports_to = m.employee_id;

-- SELECT e.employee_id, e.first_name, m.first_name as manager
-- FROM employees e
-- JOIN employees m
-- ON e.reports_to = m.employee_id;

-- we have to use different aliases 


-- # task 


-- # Lesson JOINING more than 2 tables
USE sql_store;

-- SELECT * 
-- FROM orders o
-- JOIN customers c
-- ON o.customer_id = c.customer_id
-- JOIN order_statuses os
-- ON o.status = os.order_status_id;

-- SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name as status
-- FROM orders o
-- JOIN customers c
-- ON o.customer_id = c.customer_id
-- JOIN order_statuses os
-- ON o.status = os.order_status_id;

-- # task use sql invoicing db, for payments table show client name and payment method as text
-- USE sql_invoicing;

-- SELECT p.payment_id, p.invoice_id, p.date, p.amount, c.name as client_name, pm.name as payment
-- FROM payments p
-- JOIN clients c
-- ON c.client_id = p.client_id
-- JOIN payment_methods pm
-- ON p.payment_method = pm.payment_method_id;


-- # Lesson  5 Coumpound join condition
-- SELECT * 
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	ON oi.order_id = oin.order_id
-- 	AND oi.product_id = oin.product_id;

-- # task 


-- # Lesson 6 Implicit join syntax
-- SELECT * 
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id;
    
-- SELECT * 
-- FROM orders o, customers c
-- WHERE o.customer_id = c.customer_id;
-- this is called implicid join syntax - not recommended - if no WHERE - cross join - JOIN - condition is required
    
    
-- # task 


-- # Lesson 7 Outer join
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- JOIN orders o
-- 	ON c.customer_id = o.customer_id;
    
 -- we do not see customers with no orders - JOIN is inner join - if customer has no order - condition is not valid
 
 -- left jin - keeps all items in the left table - FROM table 
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- LEFT OUTER JOIN orders o -- outer is optional
-- 	ON c.customer_id = o.customer_id;
    
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- RIGHT JOIN orders o
-- 	ON c.customer_id = o.customer_id;    
-- right join - all items in order are present, and left table items might be not present (if no order for the customer)

-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM orders o 
-- RIGHT JOIN customers c -- same as RIGHT OUTER JOIN
-- 	ON c.customer_id = o.customer_id;  
    
-- # task - write query that joins product table and order items table to show product id, product name and quantitiy. 
-- if product has never been ordered - still need to show it

-- SELECT p.product_id, p.name, oi.quantity
-- FROM products p
-- LEFT JOIN order_items oi
-- 	ON p.product_id = oi.product_id;

-- SELECT p.product_id, p.name, oi.quantity
-- FROM order_items oi
-- RIGHT JOIN products p
-- 	ON p.product_id = oi.product_id;
    



# Lesson 8 OUTER joins on multiple tables

-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id,
--     sh.name as shipper
-- FROM customers c
-- LEFT OUTER JOIN orders o -- outer is optional
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers sh -- inner join - some orders do not have shipper
-- 	ON o.shipper_id = sh.shipper_id
-- ORDER BY c.customer_id;

-- avoid using RIGHT join - simlier to read - use LEFT joins


-- # task 
-- write query to get order data, id, customer name, shipper name and status - ordered by status
-- SELECT o.order_date, o.order_id, c.first_name as customer, sh.name as shipper, os.name as status
-- FROM orders o
-- LEFT JOIN customers c 
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers sh
-- 	ON o.shipper_id = sh.shipper_id
-- LEFT JOIN order_statuses os
-- 	ON o.status = os.order_status_id
-- ORDER BY status;


-- # Lesson 9 SELF outer join
-- USE sql_hr;

-- SELECT 
-- 	e.employee_id,
-- 	e.first_name,
--     m.first_name AS manager
-- FROM employees e
-- LEFT JOIN employees m
-- 	ON e.reports_to = m.employee_id;

-- # task 


-- # Lesson 10 USING clause - simplify 
-- SELECT 
-- 	o.order_id,
--     c.first_name
-- FROM orders o
-- JOIN customers c
-- 	USING (customer_id); -- parantacies are required
-- 	-- ON c.customer_id = o.customer_id;

-- SELECT 
-- 	o.order_id,
--     c.first_name,
--     sh.name as shipper
-- FROM orders o
-- JOIN customers c
-- 	USING (customer_id) -- parantacies are required
-- LEFT JOIN shippers sh
-- 	USING (shipper_id);
-- using keyworkd only works if the col names are the same

-- order_items table - key is order_id and product_id - same as in order_items_notes

-- SELECT * 
-- FROM order_items oi
-- JOIN order_item_notes ont
-- 	USING (order_id, product_id);

-- # task 
-- select from payments table date, add client name, amount, and payment name
-- USE sql_invoicing;

-- SELECT date, c.name as client, amount, pm.name
-- FROM payments p 
-- JOIN clients c
-- 	USING (client_id)
-- JOIN payment_methods pm
-- 	ON pm.payment_method_id = p.payment_method;


-- # Lesson 11 NATURAL join
SELECT o.order_id, c.first_name 
FROM orders o
NATURAL JOIN customers c;  -- unexpected 
-- # task 


-- # Lesson 12 Cross joins - all combinations of customer and products
-- SELECT 
-- 	c.first_name AS customer,
--     p.name AS product
-- FROM customers c
-- CROSS JOIN products p -- explicit join
-- ORDER BY c.first_name;

-- SELECT 
-- 	c.first_name AS customer,
--     p.name AS product
-- FROM customers c, products p
-- ORDER BY c.first_name;

-- # task - do cross join between shippers and products - implicit and explicit syntax

-- SELECT sh.name as shipper, p.name as product
-- FROM shippers sh
-- CROSS JOIN products p
-- ORDER BY shipper;

-- SELECT sh.name as shipper, p.name as product
-- FROM shippers sh, products p
-- ORDER BY shipper ASC;

-- # Lesson 13 UNIONS - combine records from multiple queries 
-- SELECT 
-- 	order_id,
--     order_date,
--     'Active' as status
-- FROM orders 
-- WHERE order_date >= '2019-01-01'
-- UNION
-- SELECT 
-- 	order_id,
--     order_date,
--     'Archived' as status
-- FROM orders 
-- WHERE order_date < '2019-01-01';

-- SELECT first_name
-- FROM customers
-- UNION 
-- SELECT name
-- FROM shippers;

-- # task - display customers with type - if points < 2000 - Bronze, if < 3000 - Silver if > - GOLD
SELECT customer_id, first_name, points, "Bronze" as type
FROM customers
WHERE points <= 2000
UNION 
SELECT customer_id, first_name, points, "Silver" as type
FROM customers
WHERE points > 2000 AND points <= 3000 
-- WHERE points BETWEEN 2000 AND 3000
UNION 
SELECT customer_id, first_name, points, "Gold" as type
FROM customers
WHERE points > 3000
ORDER BY first_name;


