create database syit2025
use syit2025
/*Create Table students*/
create table students (Uidno numeric(7),Fname varchar(15),Lname varchar(15), Dob Date, Mob numeric(10),Email varchar(50),Addr varchar(28))
select * from students

/*Insert few values into students using insert*/
insert into students values 
	(2405004,'Onasus','Rodrigs','2006-02-22',1234567890,'onasus@gaymail.com','My bedroom'),
	(2405024,'Ian','Reddy','2005-10-25',0987654321,'ianredd@notgaymail.com','Onasis Bedroom')

select * from students
/* Insert another value*/
insert into students values (2405019,'Esan','Sin-ho','2005-10-09',5647382910,'esantheho@gaymail.com','His Bedroom')

/* Make Primary Key */
drop table students

create table students (Uidno numeric(7) primary key,Fname varchar(15) not null,Lname varchar(15) not null, Dob Date, Mob numeric(10) not null unique,Email varchar(50),Addr varchar(28))
select * from students

insert into students values 
	(2405004,'Onasus','Rodrigs','2006-02-22',1234567890,'onasus@gaymail.com','My bedroom'),
	(2405024,'Ian','Reddy','2005-10-25',0987654321,'ianredd@notgaymail.com','Onasis Bedroom')

/* Won't work if run twice */
insert into students values (2405005,'Esan','Sin-ho','2005-10-09',5647382910,'esantheho@gaymail.com','His Bedroom')

/* Create composite Primary Key */
create table emps (Fname varchar(10),Lname varchar(10),class varchar(5), constraint x primary key(Fname,Lname))

insert into emps values ('Raj','Nair','TY')
insert into emps values ('Raj','Naidu','FY') /* Will run */
insert into emps values ('Raj','Nair','SY') /* Will not run */

/* Create foreign key tables */
create table dept(deptno numeric(2) Primary Key,
				Dname varchar(10),Addr varchar(10))

create table emp(empno numeric(2) Primary Key, 
				Fname varchar(10), 
				Salary numeric(6), 
				DeptNo numeric(2) foreign key references dept(deptno))

insert into dept values (10,'IT','Ground Flo'),
						(20,'HR','First Flo'),
						(30,'RD','Second Flo')

insert into emp values (1,'Ian',5000,10),
						(2,'Ona',2000,20)

select * from dept
select * from emp