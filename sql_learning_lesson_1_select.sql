-- USE sql_invoicing;
-- USE sql_store;

-- SELECT customer_id, first_name FROM customers;
-- SELECT * FROM customers;

-- SELECT * 
-- FROM customers 
-- WHERE customer_id = 1
-- ORDER BY first_name;

-- SELECT 1, 2;

-- SELECT 
-- 	first_name, 
-- 	last_name, 
--     points, 
--     (points + 10) * 10 AS discount_factor
-- FROM customers;

-- SELECT 
-- 	first_name, 
-- 	last_name, 
--     points, 
--     (points + 10) * 10 AS 'discount factor'
-- FROM customers;

-- SELECT DISTINCT state FROM customers;

-- !!! Task
-- Return all the products
-- name 
-- unit price 
-- new price (unit price * 1.1)

-- SELECT name, unit_price, unit_price * 1.1 AS 'new price' FROM products;

-- # where clause 
-- SELECT * 
-- FROM customers
-- WHERE points > 3000;

-- SELECT * 
-- FROM customers
-- WHERE points >= 3000; > >= < <=


-- SELECT * 
-- FROM customers
-- WHERE state = "VA";

-- SELECT * 
-- FROM customers
-- WHERE state != "VA"; -- not in VA


-- SELECT * 
-- FROM customers
-- WHERE birth_date > '1990-01-01'

-- # task - Get the orders placed this year
-- SELECT * 
-- FROM orders
-- WHERE order_date >= '2019-01-01';

-- SELECT * 
-- FROM customers 
-- WHERE birth_date > '1990-01-01' AND points > 1000;


-- SELECT * 
-- FROM customers 
-- WHERE birth_date > '1990-01-01' OR (points > 1000 AND state = 'VA');


-- SELECT * 
-- FROM customers 
-- WHERE NOT (birth_date > '1990-01-01' OR (points > 1000 AND state = 'VA'));

 -- # task 
 -- From the order items table, get the items
-- for order #6
 -- where the total price is greater than
--  SELECT * 
--  FROM order_items
--  WHERE order_id = 6 AND quantity * unit_price > 30;
 
 -- IN operator
--  SELECT * 
--  FROM customers
--  WHERE state = 'VA' OR state = 'GA' OR state = 'FL';
 
 -- SELECT * 
--  FROM customers
--  WHERE state IN ('VA', 'FL', 'GA');

-- SELECT * 
--  FROM customers
--  WHERE state NOT IN ('VA', 'FL', 'GA');

-- # task REturn products with quantity in stock equal to 49, 38, 72
-- SELECT * 
-- FROM products
-- WHERE quantity_in_stock IN (49, 38, 72);

-- # Lesson 7 BETWEEN Operator
-- SELECT * 
-- FROM customers 
-- WHERE points >=1000 AND points <= 3000;

-- SELECT * 
-- FROM customers 
-- WHERE points BETWEEN 1000 AND 3000;

-- # task Return customers born between 1/1/1990 and 1/1/2000
-- SELECT * 
-- FROM customers 
-- WHERE birth_date >= '1990/01/01' AND birth_date <= '2000/01/01';

-- SELECT * 
-- FROM customers 
-- WHERE birth_date BETWEEN '1990/01/01' AND '2000/01/01';

-- # Lesson 8 - The LIKE Operator 
-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE 'b%';  -- starts with letter b

-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE '%b%';  -- contains letter b somewhere

-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE '%y';  -- last character is y

-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE '_____y';  -- last character is y and has 5 any characters before, exactly 6 chars

-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE 'b____y';  -- 6 chars total, first is b, last character is y
 
-- # task 
-- Get the customers whose
-- addresses contain TRAIL or AVENUE 
-- phone numbers end with 9

-- SELECT * 
-- FROM customers
-- WHERE (address LIKE '%trail%' OR address LIKE '%avenue%') AND phone LIKE '%9';

-- SELECT * 
-- FROM customers
-- WHERE (address LIKE '%trail%' OR address LIKE '%avenue%');

-- SELECT * 
-- FROM customers
-- WHERE phone LIKE '%9';

-- not ends with 9? 
-- SELECT * 
-- -- FROM customers
-- -- WHERE phone NOT LIKE '%9';


-- # Lesson 9 REGEXP operator
-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP 'field';

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP '^field$'; -- ^ - starts with, $ - ends with

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP '^field|mac|rose'; --  eather starts with field or has mac or has rose

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP '[gim]e'; --  ge, ie, me

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP '[a-h]e'; --  ae, be, ce, de, ee, fe, ge, he
-- # task 
-- Get the customers whose
-- 1) first names are ELKA or AMBUR
-- 2) last names end with EY or ON
-- 3) last names start with MY or contains SE
-- 4) last names contain B followed by R or U
-- SELECT * 
-- FROM customers
-- WHERE first_name IN('elka', 'ambur');

-- SELECT * 
-- FROM customers
-- WHERE first_name REGEXP '^elka$|^ambur$';

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP 'ey$|on$';

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP '^my|se';

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP 'b[ru]'; -- 'br|bu'

# Lesson x10 IS NULL operator
-- SELECT * FROM customers WHERE phone IS NULL;
-- SELECT * FROM customers WHERE phone IS NOT NULL;

-- # task 
-- Get the orders that are not shipped yet
-- SELECT * FROM orders WHERE shipped_date IS NULL; -- or WHERE shipper_id IS NULL;

-- # Lesson 11 ORDER BY Clause - sorting
-- for customers - customer_id is default sort column - it is primary key column

-- SELECT * 
-- FROM customers
-- ORDER BY first_name; -- ASC is default - smaller first 

-- SELECT * 
-- FROM customers
-- ORDER BY first_name DESC; -- DESC - larger first

-- SELECT * 
-- FROM customers
-- ORDER BY state, first_name;

-- SELECT * 
-- FROM customers
-- ORDER BY state DESC, first_name DESC;

-- SELECT first_name, last_name, 10 AS points
-- FROM customers
-- ORDER BY points, state;

-- SELECT first_name, last_name, 10 AS points
-- FROM customers
-- ORDER BY 1, 2; -- sort by col position, fist name and then by last name ASC, should avoid - position change


-- # task 
-- select order items for order with id 2, sorted by total price of each item descending
-- SELECT * 
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY quantity * unit_price DESC;

-- SELECT *, quantity * unit_price as total_price
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY total_price DESC;

-- # Lesson 12 LIMIT clause
-- SELECT * 
-- FROM customers
-- LIMIT 300;

-- SELECT * 
-- FROM customers
-- LIMIT 6, 3; -- skip first 6 records and show 3 customers (7, 8, 9)


-- # task 
-- Get the top three loal customers - with the most points number
SELECT * 
FROM customers
ORDER BY points DESC
LIMIT 3; -- LIMIT should be the last in query



