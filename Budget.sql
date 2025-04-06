use budget_management_system;

create table Budget(
	userID int auto_increment primary key,
	weeklyBudget double,
	monthlyBudget double,
	setDate date not null default current_date
);

create table ExchangeRates(
	fromCurrency varchar(3),
	toCurrency varchar(3),
	exchangeRate double,
	primary key(fromCurrency, toCurrency)
);


insert into ExchangeRates (fromCurrency, toCurrency, exchangeRate) values
('USD', 'KHR', 4100);

select * from ExchangeRates where fromCurrency = 'USD' and toCurrency = 'KHR';


alter TABLE Budget add date date;
alter table Budget change date setDate date;
alter table Budget modify column setDate date not null default current_date;
alter table Budget add column editDate date not null default current_date;
alter table Budget add column convertedWeeklyBudget double;
alter table Budget add column convertedMonthlyBudget double;
alter table Budget add column currency varchar(3);

-- show tables;
-- describe Budget;
-- show create table Budget;
-- drop table Budget ;


-- insert budget
DELIMITER &&

create procedure insert_budget (
	in p_weeklyBudget double,
	in p_monthlyBudget double
)
begin 
	insert into Budget (weeklyBudget, monthlyBudget)
	values (p_weeklyBudget, p_monthlyBudget);
end &&

DELIMITER ;

-- edit budget

DELIMITER &&

create procedure edit_budget (
	in p_userID int,
	in p_weeklyBudget double,
	in p_monthlyBudget double
)
begin 
	update Budget
	set weeklyBudget = p_weeklyBudget,
		monthlyBudget = p_monthlyBudget
	where userID = p_userID;
end

DELIMITER &&

-- delete budget

DELIMITER &&

create procedure delete_budget (
	in p_userID int
)
begin 
	delete from Budget
	where userID = p_userID;
end

DELIMITER &&

-- convert currency

DELIMITER &&

create function convert_currency(
	p_amount double,
	p_from_currency varchar(3),
	p_to_currency varchar(3)
)
returns double deterministic
begin 
	declare rate double 
	
	select exchangeRate from ExchangeRates
	where fromCurrency = p_from_currency and toCurrency = p_to_currency;
	
	if rate is null then
		return 0;
	end if;
	
	return round(rate * p_amount, 2);
end

DELIMITER &&
