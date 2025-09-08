create database practical7;
use practical7;

create table products (
	pid int primary key,
	pName text,
	qty int,
	rate int);

create table salesreps (
	empno int primary key,
	fName text,
	sales_amt int default 0);

create table orders (
	orderno int primary key,
	pid int foreign key references products,
	qty int,
	empno int foreign key references salesreps,
	amt int );


INSERT INTO products (pid, pName, qty, rate) VALUES
(1, 'Laptop', 50, 1000),
(2, 'Smartphone', 100, 500),
(3, 'Tablet', 75, 300),
(4, 'Headphones', 200, 150),
(5, 'Smartwatch', 80, 250),
(6, 'Keyboard', 150, 100),
(7, 'Mouse', 120, 50),
(8, 'Monitor', 40, 400),
(9, 'Printer', 60, 350),
(10, 'External Hard Drive', 90, 120);


INSERT INTO salesreps (empno, fName, sales_amt) VALUES
(101, 'Alice', 0),
(102, 'Bob', 0),
(103, 'Charlie', 0),
(104, 'David', 0),
(105, 'Eve', 0);

update salesreps set sales_amt=0


select * from products;
select * from salesreps;
select * from orders;

create trigger t1_order_insert on orders
	for insert
		as	update orders set orders.amt=products.rate*orders.qty
				from products,orders
				where products.pid=orders.pid

			update products set products.qty=products.qty-inserted.qty
			from products,inserted 
			where products.pid=inserted.pid

			update salesreps set 
			salesreps.sales_amt=salesreps.sales_amt+inserted.amt
			from salesreps,inserted 
			where salesreps.empno=inserted.empno

create trigger t2_order_delete on orders
	for delete
		as update products set products.qty=products.qty+deleted.qty
			from products,deleted
			where products.pid=deleted.pid

			update salesreps set 
			salesreps.sales_amt=salesreps.sales_amt-deleted.amt
			from salesreps,deleted
			where salesreps.empno=deleted.empno


INSERT INTO orders (orderno, pid, qty, empno, amt) VALUES
(1001, 1, 2, 101, 2000)

delete from orders
	where orderno>=1000

select * from orders;
select * from salesreps;
select * from products;

drop trigger t1_order_insert;
drop trigger t2_order_delete;

alter table salesreps
 add lName text, email text

delete from salesreps where empno>=100;
select * from salesreps;

INSERT INTO salesreps (empno, fName, lName) VALUES
(101, 'Alice', 'Smith'),
(102, 'Bob', 'Johnson'),
(103, 'Charlie', 'Williams'),
(104, 'David', 'Brown'),
(105, 'Eve', 'Davis');

create trigger t3_empEmail_insert on salesreps
	for insert
		as update salesreps
			set email=substring(fName,1,1)+'.'+cast(lName as varchar(255))+'@gmail.com'
			from salesreps

drop trigger t3_empEmail_insert;

