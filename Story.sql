-- User start using the app
CALL register_user('johndoe', 'jon@example.com', '1234567890', 'secret123', 'Student');

-- User want to change their username
CALL update_username(3, 'Alex');

-- User want to Update email
CALL update_user_email(3, 'alex12@gmail.com');

-- User want to change phone number
CALL update_user_phone(1, '098789867');

-- User want to update password
CALL update_user_password(2, '23412332');

-- User want to change user type
CALL update_user_type('Alex', 'Umemployed');

-- We want to remove user account
call delete_user(5);

-- User want to add expense
CALL add_expense(50.75,'2025-04-05','Cash','Lunch at cafe', 'USD',1 , 2);

-- User want to update their expense
CALL update_expense(3, 2, 120, 'USD', '2025-03-30', 'Updated note', 'Card');

-- User want to delete expense
CALL delete_expense(1);

-- user want to know there total expense in 1 day
SELECT get_total_expense_by_day(1, '2025-04-04');

-- User want to know their total expense so far
SELECT get_total_expense(1);

-- User want to add a new Category for expense
CALL add_category('Games', 'buying Game ');

-- User want to update the Category
CALL update_category(8, 'Bills', 'Monthly utility bills');

-- User want to Delete the Category
CALL delete_category(8);

-- We want to know the Category name
SELECT get_category_name_by_id(2);

-- User want to add income
CALL addIncome('USD', 'Free lance', 2000.00, 1);

-- User want to delete income
CALL deleteIncome(4);

-- User want to update income
CALL updateIncome(2, 'Freelance', 'USD', 1500.00);

-- User want to get their total income in USD
SELECT getTotalIncome(1);

-- User want to get their total income in KHR
SELECT getTotalIncomeKHR(1);

-- User want to get their average income
SELECT getAverageIncome(1);

-- User want to get their monthly history
CALL get_monthly_history(1, 4, 2025);

-- User want to add budget
CALL insert_budget(150.00, 600.00, 'USD', 1);

-- User want to edit budget
CALL edit_budget(1, 300.00, 1200.00, 'USD');

-- User want to delete budget
CALL delete_budget(8);






