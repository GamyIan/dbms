create database SYIT2025

use SYIT2025

create table dept(deptno int primary key,
					dept_name varchar(20))

create table course(
				cno int primary key,
				course_name varchar(20),
				no_of_credits int,
				about varchar(100),
				semester int
				)

create table prof(
				pid int primary key,
				fname varchar(20),
				email varchar(20),
				phone int,
				deptno int foreign key references dept)

create table student(
				u_id int primary key,
				fname varchar(20),
				lname varchar(20),
				dob Date,
				gender varchar(6),
				email varchar(20),
				phone int,
				addr varchar(100),
				study_year varchar(3),
				doa Date)

create table enroll(
				u_id int foreign key references student,
				cno int foreign key references course,
				constraint x primary key(u_id,cno))

create table teach(
				cno int foreign key references course,
				pid int foreign key references prof,
				constraint x2 primary key(cno,pid))

alter table course add dptno int foreign key references dept

insert into dept values()

select * from student

