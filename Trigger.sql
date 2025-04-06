CREATE TABLE AuditLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    action_type VARCHAR(50),
    table_name VARCHAR(50),
    old_value TEXT,
    new_value TEXT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger for User
DELIMITER $$

CREATE TRIGGER before_user_update
BEFORE UPDATE ON User
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, new_value, change_time)
    VALUES ('UPDATE', 'User', CONCAT('username:', OLD.username, ', email:', OLD.email),
            CONCAT('username:', NEW.username, ', email:', NEW.email), NOW());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_user_delete
AFTER DELETE ON User
FOR EACH ROW
BEGIN
    -- Log the deletion of the user in AuditLogs
    INSERT INTO AuditLogs (action_type, table_name, old_value, change_time)
    VALUES ('DELETE', 'User',
            CONCAT('user_id:', OLD.user_id, ', username:', OLD.username, ', email:', OLD.email), NOW());
END$$

DELIMITER ;

-- trigger for category

DELIMITER $$

CREATE TRIGGER before_category_delete
BEFORE DELETE ON Category
FOR EACH ROW
BEGIN
    DECLARE expense_count INT;
    SELECT COUNT(*) INTO expense_count FROM Expense WHERE category_id = OLD.category_id;
    IF expense_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete category with existing expenses';
    END IF;
END$$

DELIMITER ;

-- Trigger for expenses


DELIMITER $$

CREATE TRIGGER after_expense_update
AFTER UPDATE ON Expense
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, new_value, change_time)
    VALUES ('UPDATE', 'Expense',
            CONCAT('expense_id:', OLD.expense_id, ', amount:', OLD.amount, ', currency:', OLD.currency),
            CONCAT('expense_id:', NEW.expense_id, ', amount:', NEW.amount, ', currency:', NEW.currency), NOW());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_expense_delete
AFTER DELETE ON Expense
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, change_time)
    VALUES ('DELETE', 'Expense',
            CONCAT('expense_id:', OLD.expense_id, ', amount:', OLD.amount, ', currency:', OLD.currency), NOW());
END$$

DELIMITER ;

-- trigger for budget

DELIMITER $$

CREATE TRIGGER after_budget_update
AFTER UPDATE ON Budget
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, new_value, change_time)
    VALUES ('UPDATE', 'Budget',
            CONCAT('budget_id:', OLD.budget_id, ', weekly_budget:', OLD.weekly_budget, 
                   ', monthly_budget:', OLD.monthly_budget, ', currency:', OLD.currency),
            CONCAT('budget_id:', NEW.budget_id, ', weekly_budget:', NEW.weekly_budget, 
                   ', monthly_budget:', NEW.monthly_budget, ', currency:', NEW.currency), NOW());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_budget_delete
AFTER DELETE ON Budget
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, change_time)
    VALUES ('DELETE', 'Budget',
            CONCAT('budget_id:', OLD.budget_id, ', weekly_budget:', OLD.weekly_budget, 
                   ', monthly_budget:', OLD.monthly_budget, ', currency:', OLD.currency), NOW());
END$$

DELIMITER ;

-- Trigger for income


DELIMITER $$

CREATE TRIGGER after_income_update
AFTER UPDATE ON Income
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, new_value, change_time)
    VALUES ('UPDATE', 'Income',
            CONCAT('income_id:', OLD.income_id, ', amount:', OLD.amount, ', currency:', OLD.currency),
            CONCAT('income_id:', NEW.income_id, ', amount:', NEW.amount, ', currency:', NEW.currency), NOW());
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_income_delete
AFTER DELETE ON Income
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_type, table_name, old_value, change_time)
    VALUES ('DELETE', 'Income',
            CONCAT('income_id:', OLD.income_id, ', amount:', OLD.amount, ', currency:', OLD.currency), NOW());
END$$

DELIMITER ;










