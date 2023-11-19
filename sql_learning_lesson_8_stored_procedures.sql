-- # Lesson 1 what are Stored prcedures
-- store and organize sql
-- faster execution - optiomization to the code of stored proc
-- data security - no direct access to table, and access to stored procedures - delete access via stored proc

-- # task 

-- # Lesson 2 - Creating a Stored Procedure

-- DELIMITER $$
-- CREATE PROCEDURE get_clients()
-- BEGIN 
-- 	SELECT * FROM clients;
-- END$$
-- DELIMITER ;

-- CALL get_clients();

-- # task 
-- Create a stored procedure called get_invoices_with_balance
-- to return all the invoices with a balance > 0

-- DELIMITER $$
-- CREATE PROCEDURE get_invoices_with_balance()
-- BEGIN
-- 	SELECT * 
-- 	FROM invoices
-- 	WHERE invoice_total - payment_total > 0;
-- END$$
-- DELIMITER ;

-- v2
-- DELIMITER $$
-- CREATE PROCEDURE get_invoices_with_balance_v2()
-- BEGIN
-- 	SELECT * 
-- 	FROM invoices_with_balance
-- 	WHERE balance > 0;
-- END$$
-- DELIMITER ;

-- CALL get_invoices_with_balance_v2();

# Lesson 3 - Creating Procedure Using MySQLWorkbench
-- right click Stored Procedures in the workbench app left sidebar - create  stored procedure
-- USE `sql_invoicing`;
-- DROP procedure IF EXISTS `new_procedure`;

-- DELIMITER $$
-- USE `sql_invoicing`$$
-- CREATE PROCEDURE `new_procedure` ()
-- BEGIN
-- 	SELECT * FROM payments;
-- END$$

-- DELIMITER ;
-- # task 

-- # Lesson 4 Dropping Stored Procedures
-- DROP PROCEDURE get_clients;
-- DROP PROCEDURE IF EXISTS get_clients;
-- # task 

-- # Lesson 5 Parameters
-- DROP PROCEDURE IF EXISTS get_clients_by_state;
-- DELIMITER $$
-- CREATE PROCEDURE get_clients_by_state
-- (
-- 	state CHAR(2) -- 2 symbols
-- )
-- BEGIN 
-- 	SELECT * FROM clients c
--     WHERE c.state = state; -- not work without "c" alias for the table name
-- END $$
-- DELIMITER ;

-- CALL get_clients_by_state("CA");

-- CALL get_clients_by_state(); -- error - all params are required in mysql
-- # task 
-- Write a stored procedure to return invoices
-- for a given client 
-- get_invoices_by_client

-- DELIMITER $$
-- DROP PROCEDURE IF EXISTS get_invoices_by_client;
-- CREATE PROCEDURE get_invoices_by_client (
-- 	client_id INT
-- ) 
-- BEGIN
-- 	SELECT * FROM invoices i
-- 	WHERE i.client_id = client_id;
-- END$$
-- DELIMITER ; 

-- CALL get_invoices_by_client(1);

-- # Lesson 6 DEFAULT values for parameters

-- DROP PROCEDURE IF EXISTS get_clients_by_state;
-- DELIMITER $$
-- CREATE PROCEDURE get_clients_by_state
-- (
-- 	state CHAR(2) -- 2 symbols
-- )
-- BEGIN 
-- 	IF state IS NULL THEN 
-- 		SET state = "CA";
--     END IF;
--     
-- 	SELECT * FROM clients c
--     WHERE c.state = state; -- not work without "c" alias for the table name
-- END $$
-- DELIMITER ;

-- DROP PROCEDURE IF EXISTS get_clients_by_state;
-- DELIMITER $$
-- CREATE PROCEDURE get_clients_by_state
-- (
-- 	state CHAR(2) -- 2 symbols
-- )
-- BEGIN 
-- 	IF state IS NULL THEN 
-- 		SELECT * FROM clients c;
-- 	ELSE 
-- 		SELECT * FROM clients c
-- 		WHERE c.state = state;
--     END IF;
-- END $$
-- DELIMITER ;

-- DROP PROCEDURE IF EXISTS get_clients_by_state;
-- DELIMITER $$
-- CREATE PROCEDURE get_clients_by_state
-- (
-- 	state CHAR(2) -- 2 symbols
-- )
-- BEGIN 
-- 	SELECT * FROM clients c
-- 	WHERE c.state = IFNULL(state, c.state);
-- END $$
-- DELIMITER ;

-- CALL get_clients_by_state(NULL);
-- CALL get_clients_by_state("CA");

-- # task 
-- Write a stored procedure called get_payments 
-- with two parameters
-- 		client_id => INT 
-- 		payment_method_id => TINYINT
-- DROP PROCEDURE IF EXISTS get_payments;
DELIMITER $$
CREATE PROCEDURE get_payments (
	client_id INT,
    payment_method_id TINYINT
) 
BEGIN 
	SELECT * 
    FROM payments p 
    WHERE payment_method = IFNULL(payment_method_id, p.payment_method) AND p.client_id = IFNULL(client_id, p.client_id);
END;
DELIMITER ;

call sql_invoicing.get_payments(3, null);
call sql_invoicing.get_payments(3, 1);
call sql_invoicing.get_payments(null, 2);

-- # Lesson 7 Parameters Validation
DROP PROCEDURE IF EXISTS make_payment;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_payment`(
	invoice_id INT, 
    payment_amount DECIMAL(9, 2),
    payment_date DATE
)
BEGIN
	IF payment_amount <= 0 THEN 
		SIGNAL SQLSTATE '22003' 
			SET MESSAGE_TEXT = 'Invalid payment amount';
	END IF;
    
	UPDATE invoices i
    SET 
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END$$
DELIMITER ;

call sql_invoicing.make_payment(2, -100, '2019-01-01');
-- Error Code: 1644. Invalid payment amount


-- # task 

-- # Lesson 8 - Output Parameters
DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;

DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_client
(
	client_id INT
)
BEGIN 
	SELECT COUNT(*), SUM(invoice_total)
    FROM invoices i
    WHERE i.client_id = client_id AND payment_total = 0;
END$$
DELIMITER ;

call sql_invoicing.get_unpaid_invoices_for_client(3);


DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unpaid_invoices_for_client`(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9, 2)
)
BEGIN 
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id AND payment_total = 0;
END$$
DELIMITER ;

-- call
set @invoices_count = 0;
set @invoices_total = 0;
call sql_invoicing.get_unpaid_invoices_for_client(1, @invoices_count, @invoices_total);
select @invoices_count, @invoices_total;

-- # task 

-- # Lesson 9 Variables
-- User or session variables

-- Local variables - function scope
SELECT COUNT(*), SUM(invoice_total)
FROM invoices;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_risk_factor`()
BEGIN
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0; -- 9 digits max, 2 after decilam point
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;

	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    SELECT risk_factor;
END$$
DELIMITER ;
-- # task 

-- # Lesson 10 FUNCTIONS - can return only single value 
DELIMITER $$
CREATE FUNCTION `get_risk_factor_for_client` ()
RETURNS INTEGER
DETERMINISTIC
READS SQL DATA
MODIFIES SQL DATA
BEGIN

RETURN 1;
END
DELIMITER ;

SELECT client_id,name,get_risk_factor_for_client(client_id) as risk_factor
FROM clients;

-- good idea to store them in git
DROP FUNCTION IF EXISTS get_risk_factor_for_client;

-- # task 

-- # Lesson 11 - Naming Conventions
-- procGetRiskFactor
-- proc_get_risk_factor
-- stick to the proj conventions

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

-- # Lesson x 
-- # task 

