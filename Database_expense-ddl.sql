create database expense_management_system;
drop database expense_management_system;
use expense_management_system;

create table User(
	user_id int primary key auto_increment,
	username varchar(50) UNIQUE,
	password VARCHAR(255) NOT NULL,
	user_type varchar(50),
	email varchar(20),
	phone_num varchar(15),
	create_at timestamp default CURRENT_TIMESTAMP

);

create table Category(
	
	category_id int primary key auto_increment,
	name varchar(50),
	Detail varchar(255),

);


create table Expense(

	expense_id int primary key auto_increment,
	amount decimal(9,2),
	expense_date date,
	transaction_type varchar(10),
	expense_note varchar(255),
	currency varchar(3),
	user_id int,
	category_id int,
	
	foreign key (user_id) references User(user_id) on delete cascade,
	foreign key (category_id) references Category(category_id) on delete cascade
	
);


create table Budget(
	budget_id int auto_increment primary key,
	currency varchar(3),
	weekly_budget decimal(9,2),
	monthly_budget decimal(9,2),
	user_id int,
	
	foreign key (user_id) references User(user_id) on delete cascade 

);

create table Income(

	income_id int primary key auto_increment,
	income_name varchar(50),
	currency varchar(3),
	amount decimal(9,2),
	user_id int,
	foreign key (user_id) references User(user_id) on delete cascade

);





