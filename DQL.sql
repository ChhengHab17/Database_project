
-- query data expenses
select 
	e.expense_id, e.amount, e.currency, e.expense_date, e.expense_note, e.transaction_type, c.name category_name, c.Detail
from expense e
join category c on e.category_id = c.category_id 
where e.user_id = 1;

-- query data category
select * from category c;

-- User 
SELECT * FROM user;

SELECT * FROM user
WHERE username = 'john_doe';

SELECT * FROM user
WHERE email LIKE '%john@example.com';

SELECT * FROM user
ORDER BY create_at DESC;

SELECT * FROM user
WHERE phone_num LIKE '123%';

SELECT username, email FROM user;

SELECT COUNT(*) AS total_users FROM user;

SELECT u.user_id, u.username, i.income_name, i.amount, i.currency
FROM user u
JOIN Income i ON u.user_id = i.user_id;

SELECT u.username, b.weekly_budget, b.monthly_budget, b.currency
FROM user u
JOIN Budget b ON u.user_id = b.user_id;

SELECT u.username, e.amount, e.expense_date, e.transaction_type, e.expense_note
FROM user u
JOIN Expense e ON u.user_id = e.user_id;

SELECT u.username, c.name AS category_name, c.Detail
FROM user u
JOIN Category c ON u.user_id = c.user_id;

SELECT 
    u.username,
    c.name AS category,
    e.amount,
    e.expense_date,
    e.transaction_type,
    e.expense_note
FROM user u
JOIN Expense e ON u.user_id = e.user_id
JOIN Category c ON e.category_id = c.category_id;

SELECT *
FROM user u
LEFT JOIN Income i ON u.user_id = i.user_id
WHERE i.amount = 3000;

-- income
SELECT * FROM Income;

SELECT * FROM Income
WHERE user_id = 1;

SELECT u.username, i.income_name, i.amount, i.currency
FROM Income i
JOIN user u ON i.user_id = u.user_id;

SELECT u.username, SUM(i.amount) AS total_income
FROM Income i
JOIN user u ON i.user_id = u.user_id
GROUP BY u.user_id;

SELECT * FROM Income
WHERE currency = 'USD';

-- budget
SELECT * FROM Budget;

SELECT u.username, b.currency, b.monthly_budget, b.weekly_budget  
FROM Budget b
join user u on b.user_id = u.user_id
WHERE b.user_id = 2;

SELECT u.username, b.weekly_budget, b.monthly_budget, b.currency
FROM Budget b
JOIN user u ON b.user_id = u.user_id;

SELECT u.username, b.monthly_budget
FROM Budget b
JOIN user u ON b.user_id = u.user_id
WHERE b.monthly_budget >= 1000;

SELECT u.username, b.weekly_budget, b.monthly_budget, (b.monthly_budget - b.weekly_budget) AS difference
FROM Budget b
JOIN user u ON b.user_id = u.user_id;
