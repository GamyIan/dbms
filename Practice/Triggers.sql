create database Trig;
go
use Trig;
go



drop table if exists orders;
drop table if exists salesreps;
drop table if exists products;

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

update salesreps set sales_amt=0;

drop trigger if exists t1_order_insert;

create trigger t1_order_insert on orders
	for insert
		as update orders set orders.amt = products.rate * inserted.qty
				from products, inserted
				where inserted.pid=products.pid
		
			update products set products.qty = products.qty - inserted.qty
				from products,inserted
				where inserted.pid = products.pid

			update salesreps set salesreps.sales_amt = salesreps.sales_amt+(inserted.qty*products.rate)
				from salesreps,inserted,products
				where salesreps.empno = inserted.empno
				and products.pid = inserted.pid

drop trigger if exists t2_order_delete;
create trigger t2_order_delete on orders
	for delete
		as update products set products.qty = products.qty + deleted.qty
				from products,deleted
				where deleted.pid=products.pid
			
			update salesreps set salesreps.sales_amt = salesreps.sales_amt - deleted.amt
				from salesreps,deleted
				where deleted.empno =  salesreps.empno


drop trigger if exists t3_order_update;

create trigger t3_order_update on orders
	for update
			-- Inserted
		as update products set products.qty = products.qty - inserted.qty
				from products,inserted
				where inserted.pid = products.pid

			update salesreps set salesreps.sales_amt = salesreps.sales_amt+(inserted.qty*products.rate)
				from salesreps,inserted,products
				where salesreps.empno = inserted.empno
				and products.pid = inserted.pid

			-- Deleted
			update products set products.qty = products.qty + deleted.qty
				from products,deleted
				where deleted.pid=products.pid
			
			update salesreps set salesreps.sales_amt = salesreps.sales_amt - deleted.amt
				from salesreps,deleted
				where deleted.empno =  salesreps.empno



select * from products;
select * from salesreps;
select * from orders;

INSERT INTO orders (orderno, pid, qty, empno) VALUES
(1001, 1, 2, 101)

delete from orders where orderno=1001;

update orders set pid=2 where orderno=1001