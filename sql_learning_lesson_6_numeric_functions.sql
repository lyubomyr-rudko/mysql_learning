# Lesson 1 Numeric Functions
-- search for mysql numeric functions

SELECT ROUND(5.75, 1); -- 5.8
SELECT CEIL(5.75); -- 5.8
SELECT RAND(); 
SELECT  UPPER('sky');
SELECT  LOWER('Sky');
SELECT  LTRIM('  Sky');
SELECT  RTRIM('Sky.  ');
SELECT  TRIM('  Sky.  ');
SELECT  LEFT('asdf123', 4); -- asdf
SELECT  substring('asdf123', 5); -- 123
SELECT  LOCATE('a', 'asdf123'); -- 1
SELECT  LOCATE('q', 'asdf123'); -- 0
SELECT  REPLACE('asdf123', 'a', 'A'); -- Asdf123
SELECT  CONCAT('xyz', 'asdf123'); -- xyzasdf123


-- # task 

-- # Lesson 2 Date Functions
SELECT NOW(), CURDATE(), CURTIME();
SELECT YEAR(NOW());
SELECT MONTH(NOW()); 
SELECT MONTHNAME(NOW());
SELECT DAY(NOW());
SELECT DAYNAME(NOW());
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT EXTRACT(MONTH FROM NOW());
SELECT EXTRACT(HOUR FROM NOW());
-- # task 
-- get orders for current year
USE sql_store;

SELECT * 
FROM orders
WHERE order_date >= '2019-01-01';

SELECT CONCAT(YEAR(NOW()), '-', MONTH(NOW()), '-', DAY(NOW()));

SELECT * 
FROM orders
-- WHERE order_date >= CONCAT(YEAR(NOW()), '-', MONTH(NOW()), '-', DAY(NOW()));
WHERE YEAR(order_date) >= YEAR(NOW());

SELECT DISTINCT YEAR(order_date) 
FROM orders;

-- # Lesson 3 Formatting Dates and Times

SELECT DATE_FORMAT(NOW(), '%M %d, %Y'); -- November 14, 2023
SELECT TIME_FORMAT(NOW(), '%H:%i'); -- 18:52
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY); -- 2023-11-15 18:52:52 - NEXT DAY
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR); -- 2024-11-14 18:53:17 - NEXT YEAR
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR); -- 2022-11-14 18:53:38 - PREV YEAR
SELECT DATEDIFF('2019-01-05', '2018-01-05'); -- 365 - IN DAYS 
SELECT DATEDIFF('2019-01-05', '2020-01-05'); --  -365 - IN DAYS
SELECT TIME_TO_SEC('00:01'); -- 60 SECONDS IN 1 MINUTE 'HH:MM'
SELECT TIME_TO_SEC('09:00') - TIME_TO_SEC('09:05'); -- -300 SEC


-- # task IFNULL and COALESCE functions

USE sql_store;

SELECT 
	order_id, 
    IFNULL(shipper_id, 'Not assigned') AS shipper -- default if null to given text
FROM orders;

SELECT 
	order_id, 
    COALESCE(shipper_id, comments, 'Not assigned') AS shipper -- default the first non-null value
FROM orders;
-- # task 
-- for customers table display customer name and phone number, and Unknown if no phone number
SELECT 
	CONCAT(first_name, ' ', last_name) as customer, 
    IFNULL(phone, 'Unknown') as phone
FROM customers;

-- # Lesson 7 If Function
SELECT 
	order_id,
    order_date,
	IF(
		YEAR(order_date) = '2019', 
        'CURRENT', 
        'OLD'
	) as is_current 
    -- IF(YEAR(order_date) = YEAR(NOW()), 'CURRENT', 'OLD') as is_current 
FROM orders;
-- # task 
-- write a query that for a given product returns product_id, name, orders number and frequency (Once or Many Times)

SELECT product_id
FROM order_items;

SELECT 
	product_id, 
    p.name, 
    count(product_id) as orders,
    IF(count(product_id) > 1, "MANY", "ONCE") as freq
FROM order_items
JOIN products p USING(product_id)
GROUP by product_id, name;

SELECT 
	product_id, 
    name, 
    count(*) as orders,
    IF(count(*) > 1, "MANY", "ONCE") as freq
FROM products p  
JOIN order_items USING(product_id)
GROUP by product_id, name;

-- # Lesson 8 CASE Operator
SELECT 
	order_id,
    CASE 
		WHEN YEAR(order_date) = YEAR(NOW()) - 4 THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW()) - 5 THEN 'Last year'
        WHEN YEAR(order_date) < YEAR(NOW()) - 6 THEN 'Archived'
        ELSE 'FUTURE'
	END AS category
FROM orders;
        
-- # task 
-- classify customers based on points - GOLD > 3000, SILVER - 2000-3000 or BRONZE < 2000

SELECT 
	CONCAT(first_name, ' ', last_name) as customer,
    points,
    CASE
		WHEN points > 3000 THEN 'GOLD'
        WHEN points BETWEEN 2000 AND 3000 THEN 'SILVER'
        WHEN points < 2000 THEN 'BRONZE'
    END AS category
FROM customers
ORDER BY points DESC;

SELECT 
	CONCAT(first_name, ' ', last_name) as customer,
    points,
    CASE
		WHEN points > 3000 THEN 'GOLD'
        WHEN points >= 2000 THEN 'SILVER'
        ELSE 'BRONZE'
    END AS category
FROM customers
ORDER BY points DESC;

    

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

