-- # Lesson 1 Creating Vivew
USE sql_invoicing;

CREATE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) as total_sales
FROM clients c 
JOIN invoices i USING(client_id)
GROUP BY client_id, name;

SELECT * 
FROM sales_by_client
WHERE total_sales > 800;

SELECT * 
FROM sales_by_client
JOIN clients USING(client_id);
  
-- # task 
-- Create a view to see the balance 
-- for each client. 

-- call it clients_balance

-- client_id
-- name
-- balance - substract payment_total from invoice_total in invoices table
CREATE VIEW clients_balance AS
SELECT 
	c.client_id,
    c.name, 
	SUM(i.invoice_total - i.payment_total) as balance
FROM clients c
JOIN invoices i USING(client_id)
GROUP BY c.client_id, c.name;

SELECT * FROM clients_balance;

-- # Lesson 2 Altering and Dropping views
CREATE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) as total_sales
FROM clients c 
JOIN invoices i USING(client_id)
GROUP BY client_id, name;

DROP VIEW sales_by_client; -- DROP view

CREATE OR REPLACE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) as total_sales
FROM clients c 
JOIN invoices i USING(client_id)
GROUP BY client_id, name;

SELECT * FROM sales_by_client;

-- mouse hover on View - config btn - click
CREATE OR REPLACE
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sales_by_client` AS
    SELECT 
        `c`.`client_id` AS `client_id`,
        `c`.`name` AS `name`,
        SUM(`i`.`invoice_total`) AS `total_sales`
    FROM
        (`clients` `c`
        JOIN `invoices` `i` ON ((`c`.`client_id` = `i`.`client_id`)))
    GROUP BY `c`.`client_id` , `c`.`name`
    ORDER BY total_sales DESC;
    
-- # task 

-- # Lesson 3 Updatable View
-- Updatable view is the view that DOES NOT have the following:
-- DISTINCT
-- Aggregate Functions (MIN, MAX, SUM)
-- GROUP BY / HAVING
-- UNION 

-- create a view for invoices table that icluddes balance for each invoice
CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    (invoice_total - payment_total) AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0;

DELETE FROM invoices_with_balance WHERE invoice_id = 123;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 1;

SELECT * FROM invoices_with_balance;
-- # task 

-- # Lesson 4 - The WITH OPTION CHECK clause

SELECT * FROM invoices_with_balance;

UPDATE invoices_with_balance
SET  payment_total = invoice_total
WHERE invoice_id = 1; 
-- row with id 1 excluded from the view 

 CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    (invoice_total - payment_total) AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION; -- THIS BLOCKS update view when rows are hidden 

UPDATE invoices_with_balance
SET  payment_total = invoice_total
WHERE invoice_id = 2; 
-- Error Code: 1369. CHECK OPTION failed 'sql_invoicing.invoices_with_balance'	0.0013 sec

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

