-- # Lesson 1 Aggregate Functions
-- MAX MIN 
-- USE sql_invoicing;

-- SELECT MAX(invoice_total) as highest, -- no SPACE after MAX
-- 		MIN(invoice_total) as lowest,
--         AVG(invoice_total ) as avrege,
--         SUM(invoice_total * 1.1) as total,
--         COUNT(invoice_total) as number, -- operate on non-null values 
--         COUNT(payment_date) as num2, 
--         COUNT(client_id) as num3,
--         COUNT(DISTINCT client_id) as num4
-- FROM invoices
-- WHERE invoice_date > '2019-07-01';


-- # task 
-- date_range  		| total_sales | total_payments | what_we_expect
-- First half of 2019 	| 1539.07	  | 662.69		   | 876.38
-- Second half of 2019 | 1051.53	  | 355.02		   | 696.51
-- Total 				| 2590.60	  | 1017.71		   | 1572.89



-- SELECT 
-- 'Fist half 2019' as date_range, 
-- SUM(invoice_total) as total_sales, 
-- SUM(payment_total) as total_payments, 
-- -- (SUM(invoice_total) - SUM(payment_total)) as what_expect
-- (SUM(invoice_total - payment_total)) as what_expect
-- FROM invoices
-- WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
-- UNION 
-- SELECT 
-- 'Second half 2019' as date_range, 
-- SUM(invoice_total) as total_sales, 
-- SUM(payment_total) as total_payments, 
-- (SUM(invoice_total) - SUM(payment_total)) as what_expect
-- FROM invoices
-- WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
-- UNION
-- SELECT 
-- 'Total' as date_range, 
-- SUM(invoice_total) as total_sales, 
-- SUM(payment_total) as total_payments, 
-- (SUM(invoice_total) - SUM(payment_total)) as what_expect
-- FROM invoices
-- WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';

-- # Lesson 2 The Group by Clause

-- SELECT client_id,  SUM(invoice_total) as total_sales
-- FROM invoices
-- WHERE invoice_date >= '2019-07-01'
-- GROUP BY client_id 
-- ORDER BY total_sales DESC; 


-- SELECT state, city, SUM(invoice_total) as total_sales
-- FROM invoices i
-- JOIN clients c USING (client_id)
-- GROUP BY state, city;

-- # task 
-- date payment_method total_payments

-- SELECT 
-- 	date, 
--     pm.name as payment_method, 
--     SUM(amount) as total_payments
-- FROM payments p 
-- JOIN payment_methods pm ON pm.payment_method_id = p.payment_method 
-- GROUP BY date, payment_method
-- ORDER BY date;

-- # Lesson 3 The Having clause 
-- SELECT 
-- 	client_id,  
-- 	SUM(invoice_total) as total_sales
-- FROM invoices
-- -- WHERE total_sales > 500 -- will not work - group is not yet applied
-- GROUP BY client_id 
-- HAVING total_sales > 500 -- this is filtering after groupping, before order by
-- ORDER BY total_sales;

-- SELECT 
-- 	client_id,  
-- 	SUM(invoice_total) as total_sales,
--     COUNT(*) AS number_of_invoices
-- FROM invoices
-- -- WHERE total_sales > 500 -- will not work - group is not yet applied
-- GROUP BY client_id 
-- HAVING total_sales > 500 AND number_of_invoices > 5 -- this is filtering after groupping, before order by
-- -- HAVING number > 10 -- unknown column - may only use col in select clause
-- ORDER BY total_sales;

-- # task 
-- Get the customers
-- located in Virginia
-- who have spent more than $100
-- SELECT * FROM customers
-- WHERE state = 'VA';

SELECT first_name, state, SUM(oi.quantity * oi.unit_price) as spend
FROM customers
LEFT JOIN orders o USING (customer_id)
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE state = 'VA'
GROUP BY first_name
HAVING spend > 150;


SELECT 
	customer_id,
    first_name,
    last_name,
    SUM(oi.quantity * oi.unit_price) as sales
FROM customers
JOIN orders o USING (customer_id)
JOIN order_items oi ON o.order_id = oi.order_id
WHERE state = 'VA'
GROUP BY 
	customer_id
HAVING sales > 150;


-- # Lesson 4 TH ROLLUP Operator 
USE sql_invoicing;

-- SELECT 
-- 	client_id,
--     SUM(invoice_total) AS total_sales
-- FROM invoices
-- GROUP BY client_id WITH ROLLUP;

SELECT 
	state, 
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state, city WITH ROLLUP; -- sum for each of the group

-- # task 
-- write a query to get payment_method and total for each payment method, with rollup

SELECT pm.name as payment_method, SUM(amount)
FROM payments p
JOIN payment_methods pm on pm.payment_method_id = p.payment_method
GROUP BY pm.name WITH ROLLUP;


# Lesson x 
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

