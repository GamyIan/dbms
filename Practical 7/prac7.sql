create database practical7
use practical7

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

-- Q1. Retrieve all members who borrowed at least one book.
select * from Member 
	where MemberID in (select MemberID from Borrow);

-- Q2. List all books along with their authors using an INNER JOIN
select b.Title, a.Name from Book b join BookAuthor ba on b.ISBN=ba.ISBN join Author a on ba.AuthorID=a.AuthorID

-- Q3. Find members who have not borrowed any book (Left Outer Join).
select * from Member m left outer join Borrow bw on m.MemberID = bw.MemberID where bw.BorrowID is null;

select * from Member m where m.MemberID not in (select MemberID from Borrow);

-- Q4. Show all books that have never been borrowed (NOT IN subquery)
select * from Book where ISBN not in (select ISBN from Borrow);

-- Q5. Retrieve the latest borrowed book for each member (correlated subquery)
select m.Name, b.Title from Member m, Book b, Borrow bw
	where m.MemberID=bw.MemberID
	and b.ISBN=bw.ISBN
	and bw.BorrowDate = (select max(bw2.BorrowDate) from Borrow bw2
							where bw2.MemberID=bw.MemberID);

-- Q6. List all authors who have written more than 3 books (GROUP BY + HAVING)
select a.Name,count(*) 'Books_Written' from Author a join BookAuthor ba on a.AuthorID=ba.AuthorID
	group by ba.AuthorID,a.Name
	having count(*) > 3;

-- Q7. Find members who borrowed books published after 2015
select m.Name, b.Title,b.YearOfPublication from Member m, Book b, Borrow bw
	where m.MemberID=bw.MemberID
	and b.ISBN=bw.ISBN
	and b.YearOfPublication>'2015-01-01'

-- Q8. Display books and the number of times each has been borrowed.
select b.Title, count(bw.ISBN) from Book b left outer join Borrow bw
	on b.ISBN=bw.ISBN
	group by bw.ISBN,b.Title

-- Q9. Find members who borrowed books by a particular author (say "Chetan Bhagat")
select m.Name from Member m, Borrow bw, Author a, BookAuthor ba
	where m.MemberID=bw.MemberID
	and ba.ISBN=bw.ISBN
	and a.AuthorID=ba.AuthorID
	and a.Name='John Doe'; -- Replace John Doe with Chetan Bhagat or whichever author

-- Q10. Show all books along with their authors, even if a book has no author listed (LEFT JOIN).
select b.Title,a.Name from Book b left outer join BookAuthor ba on b.ISBN=ba.ISBN left outer join Author a on ba.AuthorID=a.AuthorID

-- Q11. Retrieve members who borrowed more books than the average borrowing count (Subquery with AVG)
select m.Name, count(*) 'Books_Borrowed' from Member m, Borrow bw, (select m.Name, count(*) from Member m, Borrow bw
																		where m.MemberID=bw.MemberID
																		group by m.MemberID, m.Name) c
	where m.MemberID=bw.MemberID
	group by m.MemberID, m.Name
	having count(*) >= avg();

-- Q18. Select books borrowed by all members

-- Need to check if this ISBN occurs at least once for every member
select b.Title from Book b, Borrow bw,Member m
	where b.ISBN=bw.ISBN
	and bw.ISBN = ALL (select mm.MemberID from Member mm)

select b.Title, count(bw.ISBN) from Book b join Borrow bw
	on b.ISBN=bw.ISBN
	group by bw.ISBN,b.Title




-- Q21. Name of the member who has taken maximum number of books (use ALL operator)








