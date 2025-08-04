create database practical6
use practical6

create table Member( MemberID int Primary Key,
					 Name varchar(100),
					 Address varchar(200),
					 Phone int,
					 MembershipDate date);

create table Book(ISBN int Primary Key, Title varchar(100), Publisher varchar(100), YearOfPublication date);

create table Author(AuthorID int Primary Key, Name varchar(100));

create table BookAuthor(ISBN int Foreign Key references Book, AuthorID int Foreign Key references Author
						Constraint x Primary Key(ISBN,AuthorID));

create table Borrow(BorrowID int Primary Key, MemberID int foreign key references Member,
					BorrowDate date, ISBN int foreign key references Book, DueDate date, LibrarianID int);

-- Insert data into Member table
INSERT INTO Member (MemberID, Name, Address, Phone, MembershipDate) 
VALUES
(1, 'Alice Smith', '123 Maple St, Springfield', 5551234, '2023-01-15'),
(2, 'Bob Johnson', '456 Oak St, Springfield', 5552345, '2022-07-22'),
(3, 'Charlie Brown', '789 Pine St, Springfield', 5553456, '2024-03-12'),
(4, 'David Wilson', '101 Birch St, Springfield', 5554890, '2022-11-25'),
(5, 'Eva Green', '202 Cedar St, Springfield', 5555901, '2021-05-30'),
(6, 'Fiona Clark', '303 Elm St, Springfield', 5789012, '2023-02-18'),
(7, 'George Turner', '404 Willow St, Springfield', 7890123, '2020-07-09'),
(8, 'Hannah Moore', '505 Ash St, Springfield', 5551234, '2022-10-01'),
(9, 'Ian Mitchell', '606 Pine St, Springfield', 5012345, '2021-08-20'),
(10, 'Jackie Lewis', '707 Oak St, Springfield', 123456, '2024-05-10');

-- Insert data into Book table
INSERT INTO Book (ISBN, Title, Publisher, YearOfPublication) 
VALUES
(1001, 'The Great Adventure', 'HarperCollins', '2022-05-01'),
(1002, 'Mystery of the Unknown', 'Penguin', '2021-08-14'),
(1003, 'History Revisited', 'Random House', '2023-02-10'),
(1004, 'The Lost City', 'Macmillan', '2023-07-22'),
(1005, 'Code Breakers', 'Oxford Press', '2021-11-01'),
(1006, 'Digital Future', 'Springer', '2024-01-15'),
(1007, 'Nature Unveiled', 'Wiley', '2022-03-25'),
(1008, 'Journey Beyond', 'Pearson', '2021-10-05'),
(1009, 'The Art of Coding', 'Elsevier', '2020-12-12'),
(1010, 'The Secret Universe', 'Routledge', '2023-06-20');

-- Insert data into Author table
INSERT INTO Author (AuthorID, Name)
VALUES
(1, 'John Doe'),
(2, 'Jane Roe'),
(3, 'Alice Wonderland'),
(4, 'Bob Smith'),
(5, 'Clara Johnson'),
(6, 'David Lee'),
(7, 'Eva White'),
(8, 'George King'),
(9, 'Hannah Green'),
(10, 'Ian Brown');

-- Insert data into BookAuthor table
INSERT INTO BookAuthor (ISBN, AuthorID) 
VALUES
(1001, 1),
(1001, 2),
(1002, 2),
(1002, 3),
(1003, 3),
(1003, 4),
(1004, 5),
(1005, 6),
(1006, 7),
(1007, 8),
(1008, 9),
(1009, 10),
(1010, 1);

-- Insert data into Borrow table
INSERT INTO Borrow (BorrowID, MemberID, BorrowDate, ISBN, DueDate, LibrarianID) 
VALUES
(1, 1, '2023-06-15', 1001, '2023-06-30', 101),
(2, 2, '2024-01-10', 1002, '2024-01-24', 102),
(3, 3, '2024-02-01', 1003, '2024-02-15', 103),
(4, 4, '2023-12-05', 1004, '2023-12-19', 104),
(5, 5, '2021-09-22', 1005, '2021-10-06', 105),
(6, 6, '2024-03-11', 1006, '2024-03-25', 106),
(7, 7, '2023-11-13', 1007, '2023-11-27', 107),
(8, 8, '2022-04-10', 1008, '2022-04-24', 108),
(9, 9, '2024-01-05', 1009, '2024-01-19', 109),
(10, 10, '2023-07-01', 1010, '2023-07-15', 110);

/* Q1 - List all books borrowed by each member along with their names and borrow dates */
select m.Name, b.Title, bw.BorrowDate from Borrow bw,Member m, Book b
	where bw.MemberID = m.MemberID
	and bw.ISBN = b.ISBN

/* Q2 - Display all authors and the titles of the books they have written */
select a.Name, b.Title from Author a, Book b, BookAuthor ba
	where ba.AuthorID=a.AuthorID
	and ba.ISBN = b.ISBN
	group by a.Name,b.Title /* Sorts the data */

/* Q3 - Count the total number of books borrowed by each member. */
select m.Name, count(*) 'Books_Borrowed' 
	from Member m, Borrow bw
	where m.MemberID=bw.MemberID
	group by m.MemberID,m.Name

/* Q4 - Find members who have borrowed more than 5 books */
select m.Name, count(*) 'Books_Borrowed' 
	from Member m, Borrow bw
	where m.MemberID=bw.MemberID
	group by m.MemberID,m.Name
	having count(*) > 5

/* Q5 - Show the number of books borrowed each year */
select year(BorrowDate), count(*) 'Books_Borrowed'
	from Borrow
	group by year(BorrowDate)

/* Q6 - List members who have borrowed books written by "J.K. Rowling" */
select distinct m.Name
	from Member m, Borrow bw, BookAuthor ba, Author a
	where bw.MemberID=m.MemberID
	and bw.ISBN=ba.ISBN
	and ba.AuthorID=a.AuthorID
	and a.Name = 'J.K. Rowling'

/* Q7 - Identify books that have more than one author */
select b.Title,count(*) 'Authors'
	from Book b, BookAuthor ba
	where b.ISBN=ba.ISBN
	group by b.ISBN,b.Title
	having count(*) > 1;

/* Q8 - Find the top 5 most borrowed books. */
select top 5 b.Title, count(*) 'Borrows'
	from Book b, Borrow bw
	where b.ISBN=bw.ISBN
	group by b.ISBN,b.Title
	order by count(*) desc

/* Q9 - Show the names of members who borrowed books published before the year 2000 */
select distinct m.Name
	from Member m, Borrow bw, Book b
	where m.MemberID=bw.MemberID
	and b.ISBN = bw.ISBN
	and year(YearOfPublication)<2000

/* Q10 - Display the number of books written by each author, ordered by the count
in descending order */
select a.Name, count(*) 'Books_Written'
	from Author a, BookAuthor ba
	where a.AuthorID = ba.AuthorID
	group by a.AuthorID,a.Name
	order by count(*) desc

/* Q11 - List all members who haven't borrowed any books */
select distinct m.Name
	from Member m, Borrow bw
	where m.MemberID not in (bw.MemberID)

/* Q12 - Find the members who have borrowed the average number of books total books borrowed*/
select mm.Name, avg(c.Books_Borrowed) 
	from Member mm, 
		(select m.MemberID, count(*) 'Books_Borrowed'
		from Member m, Borrow bw
		where m.MemberID = bw.MemberID
		group by m.MemberID,m.Name) c /* Using Inline view */
	where mm.MemberID=c.MemberID
	group by mm.MemberID,mm.Name

/* Q13 - Retrive the latest borrowed book for each member */
select m.Name, b.Title 'Latest_Borrowed'
	from Member m, Book b, Borrow bw
	where m.MemberID=bw.MemberID
	and b.ISBN=bw.ISBN
	group by m.MemberID,m.Name
	having bw.BorrowDate = (select max(bw.BorrowDate)
		from Member m, Book b, Borrow bw
		where m.MemberID=bw.MemberID
		and b.ISBN=bw.ISBN
		group by m.MemberID,m.Name)

	