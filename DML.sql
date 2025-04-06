use expense_management_system;

insert into user (username, email, phone_num, password)
values 	
	('john_doe', 'john@example.com', '088976655', '12345678'),
	('jane_smith', 'jane@example.com', '098765678', '23412332'),
	('alex_brown', 'alex@example.com', '099887766', '233445566'),
	('emma_white', 'emma@example.com', '011223344', '123456789'),
	('mike_jones', 'mike@example.com', '012345678', '000000000');

insert into budget (currency, weekly_budget, monthly_budget, user_id)
values 	
	('USD', 200.00, 800.00, 1),
  	('USD', 300.00, 1200.00, 2),
  	('USD', 250.00, 1000.00, 3),
	('KHR', 50000.00, 200000.00, 4),
	('KHR', 75000.00, 300000.00, 5);

insert into Category (name, detail)
values 
  ('Food', 'Expenses related to groceries, dining out, and beverages'),
  ('Travel', 'Expenses for transportation, accommodations, and travel-related activities'),
  ('Utilities', 'Monthly bills such as electricity, water, internet, and gas'),
  ('Entertainment', 'Spending on movies, concerts, subscriptions, and leisure activities'),
  ('Healthcare', 'Expenses for medical appointments, medications, and health insurance'),
  ('Education', 'Spending on tuition, books, and other educational resources'),
  ('Other', 'Miscellaneous expenses that do not fit into other categories');


insert into Expense (amount, expense_date, transaction_type, expense_note, currency, user_id, category_id)
values 
  (45.50, '2025-04-01', 'cash', 'Lunch at a local restaurant', 'USD', 1, 1),
  (120.00, '2025-03-30', 'digital', 'Go to Japan', 'USD', 2, 2),
  (15000.00, '2025-03-28', 'cash', 'Go to hospital', 'KHR', 3, 4);

insert into Income (currency, income_name, amount, user_id)
values
  ('USD', 'Monthly Salary', 1500.00, 1),
  ('USD', 'Monthly Salary', 2200.00, 2),
  ('KHR', 'Monthly Salary', 1800000.00, 3);


