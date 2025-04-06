CREATE VIEW user_profile_summary AS
SELECT 
    u.user_id,
    u.username,
    u.email,
    u.phone_num,
    b.weekly_budget,
    b.monthly_budget,
    i.amount AS income_amount,
    i.currency AS income_currency,
    (SELECT SUM(e.amount) 
     FROM Expense e 
     WHERE e.user_id = u.user_id) AS total_expense
FROM user u
LEFT JOIN Budget b ON u.user_id = b.user_id
LEFT JOIN Income i ON u.user_id = i.user_id;
select * from user_profile_summary;


CREATE VIEW view_income_details AS
SELECT 
    i.income_id,
    i.income_name,
    i.currency,
    i.amount,
    i.user_id,
    u.username,
    u.email
FROM Income i
JOIN User u ON i.user_id = u.user_id;

SELECT * FROM view_income_details;
-- view for expense
create view view_expense_details as
select 
    e.expense_id,
    e.user_id,
    u.username,
    e.category_id,
    c.name as category_name,
    c.detail as category_detail,
    e.expense_note,
    e.amount,
    e.currency,
    e.expense_date,
    e.transaction_type
from expense e
join user u on e.user_id = u.user_id
join category c on e.category_id = c.category_id;

-- view for category
create view view_categories as
select 
    c.category_id,
    c.name,
    c.Detail
from category c;