
use HotelSystem
-- Insert sample data into Hotels
INSERT INTO Hotel (HName, Locations,rating, Number)
VALUES ('Grand Plaza', 'New York',  4.5,'123-456-7890'),
('Royal Inn', 'London', 4.0, '234-567-8901'),
('Ocean Breeze', 'Miami', 4.2, '456-789-0123'),
('Mountain Retreat', 'Denver', 3.9,'567-890-1234'),
('City Lights Hotel', 'Las Vegas', 4.7, '678-901-2345'),
('Desert Oasis', 'Phoenix', 4.3, '789-012-3456'),
('Lakeview Lodge', 'Minnesota', 4.1, '890-123-4567'),
('Sunset Resort', 'California', 3.8, '345-678-9012');

-- Insert sample data into Rooms
INSERT INTO Rooms ( TypeRoom, Price, availabilites, HotelID,Roomnum)
VALUES 
('Single', 100, 1,1, 101),
('Double', 150, 1,1, 102),
('Suite', 300, 1,1, 103),
('Single', 90, 1,2, 201),
( 'Double', 140, 0,2, 202),
( 'Suite', 250, 1,3, 301),
('Single', 120, 1,4, 401),
('Double', 180, 1,4, 402),
('Suite', 350, 1,5, 501),
('Single', 130, 0,5, 502),
('Double', 200, 1,6, 601),
('Suite', 400, 0,6, 602),
('Single', 110, 1,7, 701),
('Double', 160, 1,7, 702),
('Suite', 380, 1,8, 801),
('Single', 140, 1,8, 802);															

-- Insert sample data into Guests
INSERT INTO Guest (IDproof,GName,  IDProofNumber,Contact)
VALUES 
( 'Passport','John Doe', 'A1234567', '567-890-1234'),
( 'Driver License','Alice Smith', 'D8901234', '678-901-2345'),
( 'ID Card','Robert Brown', 'ID567890', '789-012-3456'),
( '012-345-6789','Sophia Turner', 'Passport', 'B2345678'),
( 'ID Card','James Lee', 'ID890123', '123-456-7890'),
( 'Driver License','Emma White', 'DL3456789', '234-567-8901'),
( 'Passport','Daniel Kim', 'C3456789', '345-678-9012'),
( 'ID Card','Olivia Harris', 'ID234567', '456-789-0123'),
( 'Driver License','Noah Brown', 'DL4567890', '567-890-1234'),
( 'Passport','Ava Scott', 'D4567890', '678-901-2345'),
( 'ID Card','Mason Clark', 'ID345678', '789-012-3456');

-- Insert sample data into Bookings
INSERT INTO Booking (Guestid,BookingDate,status,INdate,OutDate, RoomId,TotalCost)
VALUES 
(1, '2024-10-01','Confirmed', '2024-10-05', '2024-10-10', 1, 500),
(2,  '2024-10-15','Pending', '2024-10-20', '2024-10-25', 2, 750),
(3,  '2024-10-05', 'Check-in','2024-10-07', '2024-10-09', 3, 600),
(4, '2024-10-10','Confirmed', '2024-10-12', '2024-10-15', 4,  360),
(5,'2024-10-16','Pending', '2024-10-18', '2024-10-21',  5,  540),
(6,'2024-10-05','Check-in', '2024-10-08', '2024-10-12',  6,  800),
(7,'2024-10-22','Confirmed', '2024-10-25', '2024-10-28',  7,  450),
(8, '2024-10-15','Pending', '2024-10-18', '2024-10-20',  8, 420),
(1, '2024-10-25','Confirmed', '2024-10-27', '2024-10-29',  9, 340),
(2, '2024-10-19','Check-in', '2024-10-21', '2024-10-24', 10,  480);

-- Insert sample data into Payments
INSERT INTO Payment (BookingId, PDate, Amount, PaymentMethod)
VALUES 
(1, '2024-10-02', 250, 'Credit Card'),
(1, '2024-10-06', 250, 'Credit Card'),
(2, '2024-10-16', 750, 'Debit Card'),
(4, '2024-10-11', 180, 'Credit Card'),
(4, '2024-10-14', 180, 'Credit Card'),
(5, '2024-10-17', 270, 'Debit Card'),
(5, '2024-10-20', 270, 'Credit Card'),
(6, '2024-10-06', 400, 'Cash'),
(6, '2024-10-09', 400, 'Credit Card'),
(7, '2024-10-23', 450, 'Debit Card');

-- Insert sample data into Staff
INSERT INTO Staff (Sname, posititon, HoID,ContactNumber)
VALUES 
('Michael Johnson', 'Manager',  1,'890-123-4567'),
('Emily Davis', 'Receptionist', 2, '901-234-5678'),
('David Wilson', 'Housekeeper', 3, '012-345-6789'),
('Laura Thompson', 'Manager', 4, '901-234-5678'),
('Ryan Foster', 'Receptionist', 5, '012-345-6789'),
('Sophia Roberts', 'Housekeeper', 6, '123-456-7890'),
('Ethan Walker', 'Chef', 7, '234-567-8901'),
('Liam Mitchell', 'Security', 8, '345-678-9012'),
('Isabella Martinez', 'Manager', 1, '456-789-0123');

-- Insert sample data into Reviews
INSERT INTO Review(GueId, HotelID, Rating, Comments, RDate)
VALUES 
(1, 1, 5, 'Excellent stay!', '2024-10-11'),
(2, 2, 4, 'Good service, but room was small.', '2024-10-26'),
(3, 3, 3, 'Average experience.', '2024-10-12'),
(4, 1, 4, 'Good experience, but room service was slow.', '2024-10-16'),
(5, 2, 5, 'Amazing ambiance and friendly staff.', '2024-10-20'),
(6, 3, 3, 'Decent stay, but room cleanliness needs improvement.', '2024-10-25'),
(7, 4, 4, 'Great location, will visit again!', '2024-10-27'),
(8, 5, 2, 'Not satisfied with the facilities.', '2024-10-29');
