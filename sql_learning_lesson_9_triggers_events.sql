-- # Lesson 1 TRiggers


DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_inser;

CREATE TRIGGER payments_after_inser
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices 
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END$$
DELIMITER ;

INSERT INTO payments VALUES (DEFAULT, 5, 3, '2023-01-01', 100, 1);

-- # task 
-- Create a trigger that gets
-- delete a payment.
DROP TRIGGER payment_after_delete;

DELIMITER $$
DROP TRIGGER IF EXISTS payment_after_delete;

CREATE TRIGGER payment_after_delete
AFTER DELETE ON payments
FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END$$
DELIMITER ;

DELETE FROM payments WHERE invoice_id = 3;

SHOW TRIGGERS LIKE 'payments%';
-- # Lesson 4 Using triggers for audit

USE sol_invoicing;

CREATE TABLE payments_audit
(
client_id INT,
date DATE,
amount DECIMAL(9,2),
action_type VARCHAR(50),
action_date DATETIME
);

DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_inser;

CREATE TRIGGER payments_after_inser
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices 
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
END$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS payment_after_delete;

CREATE TRIGGER payment_after_delete
AFTER DELETE ON payments
FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, OLD.amount, 'DELETE', NOW());
END$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS payment_after_update;

CREATE TRIGGER payment_after_update
AFTER UPDATE ON payments
FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, NEW.amount - OLD.amount, 'UPDATE', NOW());
END$$
DELIMITER ;

INSERT INTO payments VALUES (DEFAULT, 5, 3, '2023-01-01', 100, 1);
UPDATE payments SET amount = 100 WHERE payment_id = 20;
DELETE FROM payments WHERE invoice_id = 3;

-- # task 

-- # Lesson 5 Events
SHOW VARIABLES LIKE 'event%'; -- check if event scheduler is on
-- SET GLOBAL event_scheduler = ON;

DELIMITER $$
-- monthly hourly 
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE 
	-- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
    -- WHERE action_date < DATEADD(NOW(), INTERVAL -1 YEAR)
    -- WHERE action_date < DATESUB(NOW(), INTERVAL 1 YEAR)
END $$
DELIMITER ;
-- # task 

-- # Lesson 6 VIEW DROP and Alter Events
SHOW EVENTS;
SHOW EVENTS LIKE 'yearly%';

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;

DELIMITER $$
-- monthly hourly 
ALTER EVENT yearly_delete_stale_audit_rows
ON SCHEDULE 
	-- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
    -- WHERE action_date < DATEADD(NOW(), INTERVAL -1 YEAR)
    -- WHERE action_date < DATESUB(NOW(), INTERVAL 1 YEAR)
END $$
DELIMITER ;

ALTER EVENT yearly_delete_stale_audit_rows DISABLE;
ALTER EVENT yearly_delete_stale_audit_rows ENABLE;

SHOW EVENTS LIKE 'yearly%';

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

