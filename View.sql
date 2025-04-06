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