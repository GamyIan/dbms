create table Venue(
	VenueID int primary key,
	VenueName varchar(255) unique,
	City varchar(255));

create table Hall(
	HallID int primary key,
	VenueID int foreign key references Venue,
	HallName varchar(255),
	Capacity int CHECK(Capacity>0),
	constraint UC_Hall unique(VenueID,HallName));

create table Showtime(
	ShowID int primary key,
	HallID int foreign key references Hall,
	Title varchar(255),
	StartAt datetime,
	BasePrice int check(BasePrice>=0),
	constraint UC_Show unique(HallID,StartAt));
	
create table Customer(
	CustomerID int primary key,
	FullName varchar(255),
	Email varchar(255) unique,
	JoinedOn date,
	Tier varchar(255) default 'Basic');

create table Booking(
	BookingID int primary key,
	ShowID int foreign key references Showtime,
	CustomerID int foreign key references Customer,
	Seats int check(Seats>0),
	BookedAt datetime,
	Amount int);

create table Payment(
	PaymentID int primary key,
	BookingID int foreign key references Booking,
	Amount int check(Amount>0),
	Method varchar(255),
	PaidOn datetime,
	Status varchar(255));

create table ShowStats(
	ShowID int primary key references Showtime,
	SeatsSold int,
	SeatsAvailable int,
	LastUpdated datetime);

create table CustomerLedger(
	CustomerID int primary key references Customer,
	TotalSpend int,
	Points int,
	LastPaymentOn datetime);

create table BookingAudit(
	AuditID int primary key,
	BookingID int,
	Action varchar(255),
	ActionAt datetime);