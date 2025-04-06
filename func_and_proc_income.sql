use expense_management_system;
-- Add new income base on user id
DELIMITER &&
create or replace procedure addIncome(
	in I_currency varchar(3),
	in I_income_name varchar(50),
	in I_amount decimal(9,2),
	in I_user_id int
)
begin
	insert into Income (currency,income_name, amount, user_id)
	values (I_currency,I_income_name, I_amount, I_user_id);
end &&
DELIMITER ;

DELIMITER &&
-- Delete income base on income id
create or replace procedure deleteIncome(
    in I_income_id INT
)
begin
    delete from Income
    where income_id = I_income_id;
end &&

DELIMITER ;

DELIMITER &&
-- Update income base on income id
create or replace procedure updateIncome(
    in p_income_id INT,
    in p_income_name varchar(50),
    in p_currency VARCHAR(3),
    in p_amount DECIMAL(9,2)
)
begin
    update Income
    set currency = p_currency,
    	income_name = p_income_name,
        amount = p_amount
    where income_id = p_income_id;
end &&

DELIMITER ;
-- get total income in USD
DELIMITER &&
create function getTotalIncome(
	f_user_id int
)
returns decimal(9,2)
begin
	declare totalIncome decimal(9,2);
	select sum(
		case 
			WHEN i.currency = 'USD' THEN i.amount
            WHEN i.currency = 'KHR' THEN i.amount / 4100
            ELSE 0
        END
	) into totalIncome from Income i
	where i.user_id = f_user_id;
	return totalIncome;
end &&
DELIMITER ;

-- get total income in KHR
DELIMITER &&
create function getTotalIncomeKHR(f_user_id int)
returns decimal(12,2)
begin
	declare totalIncome decimal(12,2); 
	select getTotalIncome(f_user_id) * 4100 into totalIncome;
	return totalIncome;
end &&
DELIMITER ;

DELIMITER &&
-- get Average income in USD
create function getAverageIncome(f_user_id int)
returns decimal(9,2)
begin
    declare avg_income decimal(9,2);
    select coalesce(avg(
    	case
	    	WHEN i.currency = 'USD' THEN i.amount
            WHEN i.currency = 'KHR' THEN i.amount / 4100
            else 0
        end
    ), 0) into avg_income
    from Income i
    where user_id = f_user_id;
    return avg_income;
end &&

DELIMITER ;


