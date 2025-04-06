
-- query data expenses
select 
	e.expense_id, e.amount, e.currency, e.expense_date, e.expense_note, e.transaction_type, c.name category_name, c.Detail
from expense e
join category c on e.category_id = c.category_id 
where e.user_id = 1;

-- query data category
select * from category c;