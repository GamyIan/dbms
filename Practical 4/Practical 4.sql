/* Practical 4 */

use practical2

-- Drop tables in reverse order to avoid FK issues
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS CourseProfessor;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;

-- Create Department
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Create Student with Phone as VARCHAR(15)
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    DOB DATE,
    Gender VARCHAR(6),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(100),
    Program VARCHAR(20),
    YearOfStudy VARCHAR(2),
    DateOfAdmission DATE
);

-- Create Course
CREATE TABLE Course (
    CourseCode INT PRIMARY KEY,
    CourseName VARCHAR(20),
    Credits INT,
    Description VARCHAR(50),
    Semester INT,
    DepartmentID INT FOREIGN KEY REFERENCES Department(DepartmentID)
);

-- Create Professor with Phone as VARCHAR(15)
CREATE TABLE Professor (
    ProfessorID INT PRIMARY KEY,
    Name VARCHAR(20),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    DepartmentID INT FOREIGN KEY REFERENCES Department(DepartmentID)
);

-- Create CourseProfessor
CREATE TABLE CourseProfessor (
    CourseCode INT FOREIGN KEY REFERENCES Course(CourseCode),
    ProfessorID INT FOREIGN KEY REFERENCES Professor(ProfessorID),
    CONSTRAINT x PRIMARY KEY (CourseCode, ProfessorID)
);

-- Create Registration
CREATE TABLE Registration (
    StudentID INT FOREIGN KEY REFERENCES Student(StudentID),
    CourseCode INT FOREIGN KEY REFERENCES Course(CourseCode),
    CONSTRAINT x2 PRIMARY KEY (StudentID, CourseCode)
);

-- Insert Departments
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Civil Engineering');

-- Insert Courses
INSERT INTO Course (CourseCode, CourseName, Credits, Description, Semester, DepartmentID) VALUES
(101, 'Data Structures', 3, 'Intro to data structures', 2, 1),
(102, 'Thermodynamics', 4, 'Study of heat energy', 3, 2),
(103, 'Circuits I', 3, 'Basic electrical circuits', 1, 3),
(104, 'Algorithms', 4, 'Design of algorithms', 3, 1),
(105, 'Statics', 3, 'Statics and mechanics', 2, 4),
(106, 'DBMS', 3, 'Databases systems', 4, 1);

-- Insert Professors (make sure these IDs are consistent with CourseProfessor)
INSERT INTO Professor (ProfessorID, Name, Email, Phone, DepartmentID) VALUES
(1, 'Alice Smith', 'asmith@univ.edu', '1234567890', 1),
(2, 'Bob Johnson', 'bjohnson@univ.edu', '2345678901', 2),
(3, 'Carol Lee', 'clee@univ.edu', '3456789012', 3),
(4, 'David White', 'dwhite@univ.edu', '4567890123', 4);

-- Insert Students
INSERT INTO Student (StudentID, FirstName, LastName, DOB, Gender, Email, Phone, Address, Program, YearOfStudy, DateOfAdmission) VALUES
(1, 'John', 'Doe', '2003-04-15', 'Male', 'john.doe@email.com', '5551001', '123 Main St', 'B.Tech CSE', '2', '2022-08-01'),
(2, 'Jane', 'Smith', '2002-10-22', 'Female', 'jane.smith@email.com', '5551002', '456 Oak Ave', 'B.Tech ME', '3', '2021-08-01'),
(3, 'Mark', 'Brown', '2004-02-05', 'Male', 'mark.brown@email.com', '5551003', '789 Pine Rd', 'B.Tech EE', '1', '2023-08-01'),
(4, 'Emily', 'Clark', '2001-12-11', 'Female', 'emily.clark@email.com', '5551004', '321 Birch Ln', 'B.Tech CE', '4', '2020-08-01'),
(5, 'Chris', 'Evans', '2003-07-23', 'Male', 'chris.evans@email.com', '5551005', '654 Cedar St', 'B.Tech ME', '2', '2022-08-01'),
(6, 'Anna', 'Taylor', '2002-03-18', 'Female', 'anna.taylor@email.com', '5551006', '987 Spruce Blvd', 'B.Tech CSE', '3', '2021-08-01'),
(7, 'David', 'Wong', '2004-01-30', 'Male', 'david.wong@email.com', '5551007', '159 Maple Dr', 'B.Tech EE', '1', '2023-08-01'),
(8, 'Laura', 'King', '2003-05-25', 'Female', 'laura.king@email.com', '5551008', '753 Elm St', 'B.Tech CE', '2', '2022-08-01'),
(9, 'Tom', 'Harris', '2001-11-09', 'Male', 'tom.harris@email.com', '5551009', '951 Aspen Ct', 'B.Tech CSE', '4', '2020-08-01'),
(10, 'Rachel', 'Green', '2003-09-17', 'Female', 'rachel.green@email.com', '5551010', '357 Cherry Ave', 'B.Tech ME', '2', '2022-08-01');

-- Insert CourseProfessor
INSERT INTO CourseProfessor (CourseCode, ProfessorID) VALUES
(101, 1),
(104, 1),
(106, 1),
(102, 2),
(103, 3),
(105, 4);

-- Insert Registrations
INSERT INTO Registration (StudentID, CourseCode) VALUES
(1, 101),
(1, 104),
(1, 106),
(2, 102),
(2, 105),
(3, 103),
(3, 101),
(4, 105),
(5, 102),
(5, 105),
(6, 101),
(6, 106),
(7, 103),
(7, 104),
(8, 105),
(9, 106),
(9, 104),
(10, 102);




/* Q5 */
select p.Name,c.CourseName,count(*) 'Students'
	from CourseProfessor cp, Course c, Registration r, Professor p, Student s
	where cp.CourseCode = c.CourseCode
	and c.CourseCode = r.CourseCode
	and cp.ProfessorID = p.ProfessorID
	and s.StudentID = r.StudentID
	group by p.Name, c.CourseName
    order by p.Name asc

/* Q6 */
/* Testing */
select d.DepartmentID, d.DepartmentName, count(*) 'StudentCount'
	from Course c, Registration r, Department d
    where c.CourseCode = r.CourseCode
    and c.DepartmentID = d.DepartmentID
    group by d.DepartmentID, d.DepartmentName
/* Actual  Query */
select d.DepartmentID, d.DepartmentName, count(*) 'StudentCount'
	from Course c, Registration r, Department d
    where c.CourseCode = r.CourseCode
    and c.DepartmentID = d.DepartmentID
    group by d.DepartmentID, d.DepartmentName
    having count(*) >= ALL (select count(*)
	from Course c, Registration r, Department d
    where c.CourseCode = r.CourseCode
    and c.DepartmentID = d.DepartmentID
    group by d.DepartmentID, d.DepartmentName)

/* Q7 */
select p.Name, count(*) 'Courses'
    from CourseProfessor cp, Professor p
    where cp.ProfessorID = p.ProfessorID
    group by cp.ProfessorID, p.Name
    having count(*) >= 2

/* Q8 */
select c.CourseName, count(*) 'Students', s.
    from Course c, Registration r, Student s


/* Find the name of the Students who are not enrolled in any Course*/
select * from Student
    where StudentID not in (select distinct StudentID from Registration)