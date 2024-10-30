create database HotelSystem

use HotelSystem
create table Hotel 
(

	HID int primary key identity(1,1 ),
	Hname nvarchar(20) not null CONSTRAINT UQ_Hname UNIQUE,
	Locations NVARCHAR(120) null ,
	rating int,
	RevID int,
	Number int not null,
)
ALTER TABLE Hotel
DROP COLUMN RevID

ALTER TABLE Hotel
DROP COLUMN Number 
ALTER TABLE Hotel
ADD Number NVARCHAR(20) NOT NULL

create table Rooms 
(

	RID int primary key identity(1,1 ),
	TypeRoom nvarchar(50) not null ,
	Price float,
	availabilites  nvarchar(50) not null,
	HotelID int,
	foreign key (HotelID) references Hotel(HID)

)
ALTER TABLE Rooms
ADD Roomnum INT NOT NULL

create table Staff 
(

	SID int primary key identity(1,1 ),
	Sname nvarchar(20) not null CONSTRAINT UQ_Sname UNIQUE,
	ContactNumber int not null,
	posititon  nvarchar(50) not null,
	HoID int,
	foreign key (HoID) references Hotel(HID)

)
ALTER TABLE Staff
DROP COLUMN ContactNumber
ALTER TABLE Staff
ADD ContactNumber NVARCHAR(20) NOT NULL



create table Guest 
(


 	GID int primary key identity(1,1 ),
	IDproof nvarchar(40) not null,
	Gname nvarchar(40) not null CONSTRAINT UQ_Gname UNIQUE,
	Contact int not null,	
)
ALTER TABLE Guest
ADD IDProofNumber nvarchar(40) NOT NULL;

ALTER TABLE Guest
DROP COLUMN Contact 
ALTER TABLE Guest
ADD Contact NVARCHAR(20) NOT NULL

create table Booking 
(

	BID int primary key identity(1,1 ),
	Guestid int,
	BookingDate date not null,
	status nvarchar(20) CONSTRAINT CHK_status CHECK (status IN ('Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out' )) default 'Pending' ,
	INdate date,
	OutDate date,
	RoomId int,
	foreign key (RoomId) references Rooms(RID),
	foreign key (Guestid) references Guest(GID),
	CONSTRAINT CHK_CheckInOut CHECK (INdate <= OutDate)

)
ALTER TABLE Booking
ADD TotalCost float NOT NULL;


select * from Booking
update Booking
set TotalCost+= TotalCost* 0.1

create table Payment 
(


 	PID int primary key identity(1,1 ),
	BookingId int,
	PDate date not null,
	Amount float not null,
	PaymentMethod nvarchar(40) not null,
	
	foreign key (BookingId) references Booking(BID),
	CONSTRAINT CHK_Payment CHECK (Amount> 0)
) 

create table Review 
(
 RevID int primary key identity(1,1 ),
	GueId int,
	HotelID int,
	Rating int  CONSTRAINT CHK_Rating CHECK (Rating BETWEEN 1 AND 5),
	Comments nvarchar(200) DEFAULT 'No comments',
	RDate date not null,
	

	foreign key (GueId) references Guest(GID),
	foreign key (HotelID) references Hotel(HID),

)


ALTER TABLE Rooms
ADD CONSTRAINT CHK_RoomType CHECK (TypeRoom IN ('Single', 'Double', 'Suite'))

ALTER TABLE Rooms
ALTER COLUMN availabilites TINYINT NOT NULL --TINYINT values 0 and 1

ALTER TABLE Rooms
ADD CONSTRAINT DF_Availabilites DEFAULT 1 FOR availabilites


ALTER TABLE Rooms
ADD CONSTRAINT CHK_Availability CHECK (availabilites IN (0, 1))

ALTER TABLE Rooms
ADD  CONSTRAINT CHK_price CHECK (price >0)