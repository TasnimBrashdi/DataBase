use HotelSystem

--1. Indexing Requirements 

--Hotel Table Indexes 
create nonclustered index indexhotel
on Hotel(Hname)

create nonclustered index indexrating
on Hotel(rating)

--Room Table Indexes 

CREATE NonCLUSTERED INDEX index_room
ON Rooms(HotelID, Roomnum) 



create nonclustered index indexRoomType
on Rooms(TypeRoom)

--Booking Table Indexes 
create nonclustered index indexGhId
on Booking(Guestid)

create nonclustered index indexstatus
on Booking(status)

create index idxschedule
ON Booking(RoomId, INdate, OutDate)
------------------------------------------------------------------------------------------
--2-Views

-- View Top Rated Hotels 
create view ViewTopRatedHotels
as 
select h.Hname as 'Hotel Name',count(r.RID) as 'Total Rooms',AVG(r.price) as 'average room price '
from Hotel h inner join Rooms r on h.HID=r.HotelID and  h.rating > 4  GROUP BY h.Hname

select * from ViewTopRatedHotels

--note rating declaer as int in table 

--View Guest Bookings 
create view ViewGuestBookings 
as
select
 g.GID AS GuestID,
    COUNT(b.BID) AS 'Total Bookings',
    SUM(b.TotalCost) AS 'Total Spent'
from 
    Guest g LEFT JOIN 
    Booking b ON g.GID = b.Guestid
GROUP BY  g.GID

select * from ViewGuestBookings

--View Available Rooms
CREATE VIEW AvailableRooms
AS
select   h.HID AS HotelID,
    h.Hname AS 'Hotel Name',
    r.TypeRoom,
    COUNT(r.RID) AS 'Available Rooms',
    MIN(r.Price) AS LowestPrice
from 
    Rooms r
JOIN 
    Hotel h ON r.HotelID = h.HID
	where r.availabilites =1
	GROUP BY 
    h.HID, h.Hname, r.TypeRoom
 
SELECT * 
FROM AvailableRooms
ORDER BY HotelID, TypeRoom, LowestPrice ASC

-- View Booking Summary 
CREATE VIEW ViewBookingSummary
AS
select h.HID AS 'Hotel ID',
    h.Hname AS 'Hotel Name',
    COUNT(b.BID) AS 'Total Bookings',
    SUM(IIF(b.status = 'Confirmed', 1, 0)) AS 'Confirmed Bookings',
    SUM(IIF(b.status = 'Pending', 1, 0)) AS 'Pending Bookings',
    SUM(IIF(b.status = 'Canceled', 1, 0)) AS 'Canceled Bookings'
FROM 
    Hotel h
LEFT JOIN 
    Rooms r ON h.HID = r.HotelID
LEFT JOIN 
    Booking b ON r.RID = b.RoomId
GROUP BY 
    h.HID, h.Hname

SELECT * 
FROM ViewBookingSummary

-- View Payment History 
CREATE VIEW ViewPaymentHistory
AS
SELECT 
    g.GID AS 'Guest ID',
    g.Gname AS 'Guest Name',       
    h.HID AS 'Hotel ID',
    h.Hname AS'Hotel Name',
    b.status AS 'Booking Status',
    SUM(p.Amount) AS 'Total Payment'
FROM 
    Payment p
JOIN 
    Booking b ON p.BookingId = b.BID
JOIN 
    Rooms r ON b.RoomId = r.RID
JOIN 
    Hotel h ON r.HotelID = h.HID
JOIN 
    Guest g ON b.Guestid = g.GID
GROUP BY 
    g.GID, g.gName, h.HID, h.Hname, b.status


SELECT * 
FROM ViewPaymentHistory

---------------------------------------------------------------------------------
--3. Functions 

--Get Hotel Average Rating 
CREATE FUNCTION dbo.GetHotelAverageRating(@HoID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @AverageRating FLOAT;

    SELECT @AverageRating = AVG(Rating)
    FROM Review
    WHERE HotelID = @HoID

    RETURN @AverageRating
END

SELECT dbo.GetHotelAverageRating(1) as 'Aversge Rating '

--Get Next Available Room

CREATE FUNCTION dbo.GetNextAvailableRoom(@HotelID INT, @RoomType NVARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @RoomID INT;

    SELECT TOP 1 @RoomID = RID
    FROM Rooms
    WHERE HotelID = @HotelID
      and TypeRoom = @RoomType
      and availabilites = 1  
    ORDER BY Roomnum

    RETURN @RoomID
END

SELECT dbo.GetNextAvailableRoom(2, 'Single') AS 'Next Available RoomI D'

--Calculate Occupancy Rate 

CREATE FUNCTION dbo.GetOccupancyRate( @HotelID int)
RETURNS FLOAT
AS
BEGIN
    declare @TotalRooms int
    declare @BookedRooms int
    declare @OccupancyRate float

  
    SELECT @TotalRooms = COUNT(RID)
    FROM Rooms
    WHERE HotelID = @HotelID;

  
    SELECT @BookedRooms = COUNT(DISTINCT b.RoomId)
    FROM Booking b
    WHERE b.RoomId IN (SELECT RID FROM Rooms WHERE HotelID = @HotelID)
      and b.BookingDate >= DATEADD(DAY, -30, GETDATE())


    IF @TotalRooms > 0
    BEGIN
        SET @OccupancyRate = (@BookedRooms * 1.0 / @TotalRooms) * 100
    END
    ELSE
    BEGIN
        SET @OccupancyRate = 0
    END

    RETURN @OccupancyRate
END


SELECT dbo.GetOccupancyRate(1) AS 'Occupancy Rate'

---------------------------------------------------------------
--4. Stored Procedures 

--Mark Room Unavailable
create proc MarkRoomUnavailable @IDB INT
as 
BEGIN
    DECLARE @RoomId INT;
    DECLARE @BookingStatus NVARCHAR(20)
	SELECT @RoomId = RoomId, @BookingStatus = status
    FROM Booking
    WHERE BID = @IDB;

	IF @BookingStatus = 'Confirmed'
    BEGIN
	  UPDATE Rooms
        SET availabilites = 0
        WHERE RID = @RoomId
		 IF @@ROWCOUNT = 0
        BEGIN
		SELECT 'No room found '

		       END
    END
    ELSE
    BEGIN
	SELECT 'BOOKING NOT CONFIRMED '
	END
	END
EXEC dbo.MarkRoomUnavailable @IDB =1

--Update Booking Status 
CREATE PROC  UpdateBookingStatus @BID INT
AS
BEGIN
    DECLARE @INdate DATE
    DECLARE @OutDate DATE
    DECLARE @CurDate DATE = GETDATE()
    DECLARE @NewStatus NVARCHAR(20)
	  SELECT @INdate = INdate, @OutDate = OutDate
    FROM Booking
    WHERE BID = @BID
	 If @CurDate < @INdate
    BEGIN
        SET @NewStatus = 'Check-in'
    END
    ELSE IF @CurDate > @OutDate
    BEGIN
        SET @NewStatus = 'Check-out'
    END
    ELSE
    BEGIN
        SET @NewStatus = 'Canceled'

		END
UPDATE Booking
SET status = @NewStatus
WHERE BID = @BID
 IF @@ROWCOUNT = 0
    BEGIN
	SELECT 'NO BOOKING FOUND'
	END 
	END

EXEC dbo.UpdateBookingStatus @BID=2

--Rank Guests By Spending
CREATE PROC  sp_RankGuestsBySpending 
AS
BEGIN

SELECT g.GID, g.GName, SUM(p.Amount) AS TotalSpen,
        RANK() OVER (ORDER BY SUM(p.Amount) DESC) AS 'Spending Rank'
FROM  Guest g
    LEFT JOIN 
        Booking b ON g.GID = b.Guestid
    LEFT JOIN 
        Payment p ON b.BID = p.BookingId
GROUP BY 
        g.GID, g.GName
ORDER BY 
        TotalSpen DESC
END

EXEC dbo.sp_RankGuestsBySpending

---------------------------------------------------------------------------------
--5. Triggers

-- Update Room Availability 
Create TRIGGER trg_UpdateRoomAvailability
ON Booking 
after insert
as
BEGIN
 DECLARE @RoomId INT
   SELECT @RoomId = RoomId
    FROM inserted
 UPDATE Rooms
    SET availabilites = 0
    WHERE RID = @RoomId
	    IF @@ROWCOUNT = 0
    BEGIN
        SELECT'No room found with'
    END
END

--Calculate Total Revenue
Create TRIGGER trg_CalculateTotalRevenue
ON  Payment
after insert
as
BEGIN
    UPDATE Booking
    SET TotalCost = ISNULL(TotalCost, 0) + i.Amount
    FROM inserted i
    WHERE Booking.BID = i.BookingId
END


--Check In Date Validation

CREATE TRIGGER trg_CheckInDateValidation
On Booking
INSTEAD OF INSERT
AS
BEGIN

if EXISTS (
        select 1
        from inserted
        WHERE INdate > OutDate
    )
    BEGIN
 
       select'Check-in date cannot be greater than check-out date.'
        ROLLBACK TRANSACTION
        RETURN
    end

 
INSERT INTO Booking
(Guestid, BookingDate, status, INdate, OutDate, RoomId, TotalCost)
    select Guestid, BookingDate, status, INdate, OutDate, RoomId, TotalCost
    From inserted
END



