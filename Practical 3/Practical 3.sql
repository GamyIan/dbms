
create database practical2
use practical2
create table Student (StudentID int Primary Key,
					FirstName varchar(20),
					LastName varchar(20),
					DOB date,
					Gender varchar(6),
					Email varchar(50),
					Phone int,
					Address varchar(100),
					Program varchar(20),
					YearOfStudy varchar(2),
					DateOfAdmission date)

create table Department(DepartmentID int Primary Key,
						DepartmentName varchar(50))

create table Course (CourseCode int Primary Key,
					CourseName varchar(20),
					Credits int,
					Description varchar(50),
					Semester int,
					DepartmentID int foreign key references Department)

create table Professor(ProfessorID int Primary Key,
						Name varchar(20),
						Email varchar (50),
						Phone int,
						DepartmentID int foreign key references Department)


create table CourseProfessor(CourseCode int foreign key references Course, ProfessorID int foreign key references Professor
			constraint x Primary Key(CourseCode,ProfessorID))

create table Registration (StudentID int foreign key references Student,
							CourseCode int foreign key references Course
							constraint x2 Primary Key(StudentID,CourseCode))




/* Q1 */
select s.FirstName,c.CourseName from Student s, Course c, Registration r
		where s.StudentID=r.StudentID and c.CourseCode=r.CourseCode

/* Q2 */
select s.FirstName as StudentName, p.Name as ProfessorName from Student s,Professor p, Course c, Registration r, CourseProfessor cp
	where s.StudentID=r.StudentID and c.CourseCode=r.CourseCode 
	and c.CourseCode = cp.CourseCode and p.ProfessorID=cp.ProfessorID

/* Q3 */
select c.CourseName,d.DepartmentName from Course c, Department d
	where c.DepartmentID=d.DepartmentID

/* Q4 */
select p.Name as ProfessorName, c.CourseName from Professor p, Course c, CourseProfessor cp
	where p.ProfessorID=cp.ProfessorID and c.CourseCode=cp.CourseCode

/* Q5 */
select 


/* Join (Q4) */
select p.* from Professor p, Department d
		where p.DepartmentID=d.DepartmentID and
		d.DepartmentName='CS'

/* Subquery (Q4) */
select * from Professor where DepartmentID = (select DepartmentID from Department where DepartmentName='CS')




