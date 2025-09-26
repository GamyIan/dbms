create database LibraryDB;
use LibraryDB;

create table Branch(
	BranchID int primary key identity(1,1),
	BranchName varchar(255) not null,
	City varchar(255) not null,
	constraint UN_BN_C unique(BranchName,City));

create table Book(
	BookID int primary key identity(10,1),
	Title varchar(255),
	Author varchar(255),
	Price decimal(10,2) check(Price>0));

create table Member(
	MemberID int primary key identity(100,1),
	FullName varchar(255),
	Email varchar(255) unique not null,
	JoinDate datetime default GETDATE());

create table Loan(
	LoanID int primary key identity(1000,1),
	BookID int foreign key references Book,
	MemberID int foreign key references Member,
	BranchID int foreign key references Branch,
	LoanDate datetime not null,
	ReturnDate datetime check(ReturnDate >= LoanDate));

create trigger t1_loan_insert on Loan
	for insert
