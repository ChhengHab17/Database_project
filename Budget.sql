use budget_management_system;



-- insert budget
DELIMITER &&

create or replace procedure insert_budget (
	in p_weeklyBudget double,
	in p_monthlyBudget double,
	in p_currency varchar(3),
	in p_user_id int
)
begin 
	insert into Budget (weekly_budget, monthly_budget, currency, user_id)
	values (p_weeklyBudget, p_monthlyBudget, p_currency, p_user_id);
end &&

DELIMITER ;

-- edit budget

DELIMITER &&

create or replace procedure edit_budget (
	in p_userID int,
	in p_weeklyBudget double,
	in p_monthlyBudget double,
	in p_currency varchar(3)
)
begin 
	update Budget
	set weekly_budget = p_weeklyBudget,
		monthly_budget = p_monthlyBudget,
		currency = p_currency
	where user_id = p_userID;
end &&

DELIMITER ;

-- delete budget

DELIMITER &&

create or replace procedure delete_budget (
	in p_budgetID int
)
begin 
	delete from Budget
	where budget_id = p_budgetID;
end &&

DELIMITER ;

-- convert currency

DELIMITER &&

CREATE FUNCTION convert_currency(
    p_amount DOUBLE,
    p_from_currency VARCHAR(3),
    p_to_currency VARCHAR(3)
)
RETURNS DOUBLE DETERMINISTIC
BEGIN
    DECLARE rate DOUBLE;

    IF p_from_currency = 'USD' AND p_to_currency = 'KHR' THEN
        SET rate = 4100;
    ELSEIF p_from_currency = 'KHR' AND p_to_currency = 'USD' THEN
        SET rate = 1 / 4100;
    ELSEIF p_from_currency = p_to_currency THEN
        SET rate = 1;
    ELSE
        RETURN 0; -- Unsupported currency conversion
    END IF;

    RETURN ROUND(rate * p_amount, 2);
END &&

DELIMITER ;
