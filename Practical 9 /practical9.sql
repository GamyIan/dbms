create database practical9;
use practical9;

create table Employee (
	empno int primary key,
	Fname Text,
	Sal int,
	Deptno int)

insert into Employee 
	values (100,'Raj',50000,10),(101,'Rajesh',50000,12),(102,'Ruby',55000,10),(103,'Rony',57000,13),(104,'Rajen',57000,13);

insert into Employee values (105,'Vernon',67000,13);

select * from Employee;

-- Find employee with highest salary per Dept.
select emp.Deptno,emp.Fname,emp.Sal from Employee emp
	where emp.Sal= 
		(select max(sal) from Employee e 
			where e.Deptno=emp.Deptno)
	order by emp.Deptno;

-- Find dept having maximum number of employees
select emp.Deptno,count(*) 'Employee_count' from Employee emp
	group by emp.Deptno
	having count(*)=(select max(e.Employee_count) from (
						select Deptno,count(*) 'Employee_count' 
							from Employee
							group by Deptno) e);

-- Find dept having maximum number of employees using all operator
select emp.Deptno,count(*) 'Employee_count' from Employee emp
	group by emp.Deptno
	having count(*) >= all (select count(*) from Employee e group by e.Deptno);

-- Details of Dept having more than 3 employees
select Deptno from Employee 
	group by Deptno
	having count(*)>=3;

-- Name of the person getting the second highest Salary
select * from Employee
	where Sal=(select max(e.Sal) from Employee e
					where e.Sal != (select max(ee.Sal) from Employee ee));

-- Name of the Employee and its corresponding manager
alter table Employee
	add Manager int;

select e.Fname 'Manager', m.Fname from Employee e,Employee m
	where e.empno=m.Manager;

-- Name of the Employees whose name starts with ra and salary is more then 50000
select * from Employee	
	where Fname like 'ra%'
	and Sal > 50000

-- Name of the dept who does not have any employee
create table Dept(
	Deptno int primary key,
	dname text);

alter table Employee 
	add constraint x1 foreign key(Deptno) references Dept;

select from 
(select Deptno from Dept) except (select distinct Deptno from Employee);

select * from Dept
	where not exists(select * from Employee where Employee.Deptno=Dept.Deptno)






