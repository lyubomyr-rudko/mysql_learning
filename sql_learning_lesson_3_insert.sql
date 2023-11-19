-- # Lesson 2 INSERT row into a table
-- INSERT INTO customers
-- VALUES (
-- 	DEFAULT, 
--     'John', 
--     'Smith', 
--     '1990-01-01', 
--     NULL, -- or DEFAULT
--     'address', 
--     'city',
--     'CA',
--     DEFAULT);

-- INSERT INTO customers (
-- first_name,
-- last_name,
-- birth_date,
-- address, 
-- city, 
-- state)
-- VALUES (
--     'John', 
--     'Smith', 
--     '1990-01-01', 
--     'address', 
--     'city',
--     'CA');
--     
-- -- can reorder cols

-- INSERT INTO customers (
-- last_name,
-- first_name,
-- birth_date,
-- address, 
-- city, 
-- state)
-- VALUES (
--     'Smith', 
--     'John', 
--     '1990-01-01', 
--     'address', 
--     'city',
--     'CA');
    

-- # task 

-- # Lesson 3 Insert multiple values
-- INSERT INTO shippers (name) 
-- VALUES 
-- 	('Shipper1'),
--     ('Shipper2');

-- # task 
-- Write a statement to create 3 new products  
-- INSERT INTO products (name, quantity_in_stock, unit_price) 
-- VALUES 
-- 	("test", 10, 30),
-- 	("test2", 5, 20),
--     ("test3", 1, 40.95);

-- # Lesson 4 Inserting Hierarchy rows - multiple tables insert
-- INSERT INTO orders 
-- 	(customer_id, order_date, status)
-- VALUES 
-- 	(1, '2019-01-02', 1);

-- INSERT INTO order_items
-- VALUES (LAST_INSERT_ID(), 1, 1, 2.95),
-- 		(LAST_INSERT_ID(), 2, 1, 1.95);
	
-- # task 

-- # Lesson 5 - Creating copy of a table 
-- CREATE TABLE order_archies AS
-- SELECT * FROM orders; -- problem - copy does not have key and autoincrement

-- INSERT INTO order_archies
-- SELECT * 
-- FROM orders 
-- WHERE order_date < '2019-01-01';

-- # task 
-- invlices table - create a copy invoices_archive - only with payment (payment_date) -  but replace client_id with client_name, 
-- USE sql_invoicing;

-- CREATE TABLE invoices_archive AS
-- SELECT 
-- 	invoice_id,
--     number,
--     c.name as client_name,
--     invoice_total,
--     payment_total,
--     invoice_date,
--     due_date,
--     payment_date
-- FROM invoices 
-- JOIN clients c
-- 	USING (client_id)
-- WHERE payment_date IS NOT NULL;


# Lesson 6 - UPdating a single row
-- UPDATE invoices
-- SET payment_total = 10, payment_date = '2019-03-01'
-- WHERE invoice_id = 1;

-- UPDATE invoices
-- SET payment_total = 0, payment_date = NULL
-- WHERE invoice_id = 1;

-- UPDATE invoices
-- SET payment_total = DEFAULT, payment_date = NULL
-- WHERE invoice_id = 1;

-- UPDATE invoices
-- SET payment_total = invoice_total * 0.1, 
-- payment_date = due_date
-- WHERE invoice_id = 3;

-- # task 

-- # Lesson 7 - updating Multiple records
-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date
-- WHERE client_id IN (3, 4);

-- # task 
-- give any customers born before 1990 50 extra points
-- UPDATE customers 
-- SET points = points + 50
-- WHERE birth_date < '1990-01-01';

-- # Lesson 8 - subqueries in update statements

-- if we have a name not client id
-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date
-- WHERE client_id = 3;

-- SELECT client_id
-- FROM clients
-- WHERE name = 'Myworks';

-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date
-- WHERE client_id = (
-- 	SELECT client_id
-- 	FROM clients
-- 	WHERE name = 'Myworks'
-- );

UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE client_id IN (
	SELECT client_id
	FROM clients
	WHERE state IN ('CA', 'NY')
);


-- # task 
-- update orders table - add comment for customers with more then 3000 points, set it to Gold customer
-- SELECT * 
-- FROM orders
-- WHERE customer_id IN (
-- 	SELECT customer_id 
-- 	FROM customers
-- 	WHERE points > 3000
-- );

-- UPDATE orders
-- SET comments = 'Gold customer'
-- WHERE customer_id IN (
-- 	SELECT customer_id 
-- 	FROM customers
-- 	WHERE points > 3000
-- );

-- # Lesson 9 - delete rows
-- DELETE FROM invoices 
-- WHERE invoice_id = 1;

-- DELETE from invoices
-- WHERE client_id IN (
-- 			SELECT client_id 
-- 			FROM clients 
-- 			WHERE name = 'Myworks');

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

