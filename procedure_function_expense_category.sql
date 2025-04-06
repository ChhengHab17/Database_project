use expense_management_system;

-- insert new expense
delimiter &&

create procedure add_expense (
	in p_amount decimal(9, 2),
	in p_expense_date date,
	in p_transaction_type varchar(10),
	in p_expense_note varchar(255),
	in p_currency varchar(3),
	in p_user_id int,
	in p_category_id int
)
begin 
	insert into Expense(amount, expense_date, transaction_type, expense_note, currency, user_id, category_id)
	values (p_amount, p_expense_date, p_transaction_type, p_expense_note, p_currency, p_user_id, p_category_id);
end &&

delimiter ;

-- update expense
delimiter $$

create procedure update_expense (
    in p_expense_id int,
    in p_category_id int,
    in p_amount decimal(9,2),
    in p_currency varchar(3),
    in p_expense_date date,
    in p_expense_note varchar(255),
    in p_type_transaction varchar(10)
)
begin
    update expense
    set category_id = p_category_id,
        amount = p_amount,
        currency = p_currency,
        expense_date = p_expense_date,
        expense_note = p_expense_note,
        transaction_type = p_type_transaction
    where expense_id = p_expense_id;
end $$

delimiter ;

-- delete expense
delimiter $$

create procedure delete_expense (
    in p_expense_id int
)
begin
    delete from expense
    where expense_id = p_expense_id;
end $$

delimiter ;

-- total expense specific date
delimiter $$

create function get_total_expense_by_day (p_user_id int, p_date date)
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);
    select sum(amount) into total
    from expense
    where user_id = p_user_id
      and expense_date = p_date;
    return ifnull(total, 0);
end$$

delimiter ;

-- total expense of a user
delimiter $$

create function get_total_expense (p_user_id int)
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);
    select sum(amount) into total
    from expense
    where user_id = p_user_id;
    return ifnull(total, 0);
end$$

delimiter ;

-- add new category
delimiter $$

create procedure add_category (
    in p_name varchar(50),
    in p_detail varchar(255)
)
begin
    insert into category ( name, detail)
    values ( p_name, p_detail);
end$$

delimiter ;

-- update category
delimiter $$

create procedure update_category (
    in p_category_id int,
    in p_name varchar(50),
    in p_detail varchar(255)
)
begin
    update category
    set name = p_name,
        detail = p_detail
    where category_id = p_category_id;
end$$

delimiter ;

-- delete category
delimiter $$

create procedure delete_category (
    in p_category_id int
)
begin
    delete from category
    where category_id = p_category_id;
end$$

delimiter ;

-- get category name by id
delimiter $$

create function get_category_name_by_id (p_category_id int)
returns varchar(50)
deterministic
begin
    declare cat_name varchar(50);
    select name into cat_name
    from category
    where category_id = p_category_id;
    return cat_name;
end$$

delimiter ;