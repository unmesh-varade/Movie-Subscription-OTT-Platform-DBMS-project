USE ott_platform;

-- Users
INSERT INTO Users (name,email,phone,city,created_on) VALUES
('Aman Verma','aman.v@example.com','+919876543210','Pune','2024-05-01 10:00:00'),
('Nina Patel','nina.p@example.com','+919999111222','Bangalore','2024-07-20 09:30:00'),
('David Smith','david.s@example.co.uk','+447700900123','London','2023-11-11 08:25:00'),
('Sara Lee','sara.lee@example.com','+971501234567','Dubai','2025-01-05 15:45:00'),
('Rohit Kapoor','rohit.k@example.com','+919812345678','Mumbai','2025-03-10 11:15:00');

-- Genres
INSERT INTO Genres (name) VALUES 
('Drama'),('Action'),('Comedy'),('Thriller'),('Sci-Fi'),('Romance');

-- Movies
INSERT INTO Movies (title, release_year, duration_min, language, created_on) VALUES
('The Silent Sea',2021,102,'Korean','2024-01-01 00:00:00'),
('Midnight Chase',2019,125,'English','2024-02-01 00:00:00'),
('Love & Pixels',2023,110,'English','2024-03-01 00:00:00'),
('Quantum Break',2020,135,'English','2024-04-01 00:00:00'),
('Laugh Out Loud',2018,95,'Hindi','2024-05-01 00:00:00'),
('Edge of Tomorrow',2014,113,'English','2024-06-01 00:00:00');

-- Movie_Genres
INSERT INTO Movie_Genres (movie_id,genre_id) VALUES
(1,5), (1,4),
(2,2), (2,4),
(3,6), (3,3),
(4,5), (4,2),
(5,3),
(6,2), (6,5);

-- Subscriptions
INSERT INTO Subscriptions (user_id,plan_name,monthly_price,start_date,end_date,status) VALUES
(1,'Premium',499.00,'2025-01-01','2025-12-31','Active'),
(2,'Standard',299.00,'2024-12-15','2025-06-14','Active'),
(3,'Basic',149.00,'2023-11-11','2024-11-10','Expired'),
(4,'Premium',499.00,'2025-10-01','2026-09-30','Active'),
(5,'Standard',299.00,'2025-06-01','2025-11-30','Cancelled');

-- Payments
INSERT INTO Payments (subscription_id,amount,paid_on,method,status) VALUES
(1,499.00,'2025-01-01 09:00:00','Card','Completed'),
(2,299.00,'2024-12-15 10:10:00','UPI','Completed'),
(3,149.00,'2023-11-11 08:00:00','Card','Completed'),
(4,499.00,'2025-10-01 11:20:00','Card','Completed');

-- Watch History
INSERT INTO Watch_History (user_id,movie_id,watched_on,watch_duration_min) VALUES
(1,1,'2025-10-05 20:00:00',100),
(1,4,'2025-10-10 21:30:00',120),
(2,4,'2025-02-01 19:00:00',135),
(2,3,'2025-03-03 18:00:00',90),
(3,2,'2024-01-05 22:00:00',125),
(4,6,'2025-11-01 20:00:00',110),
(1,3,'2025-11-05 20:15:00',60),
(5,5,'2025-06-03 13:00:00',80),
(2,6,'2025-01-10 21:00:00',113);

-- Ratings
INSERT INTO Ratings (user_id,movie_id,rating,review,rated_on) VALUES
(1,1,5,'Amazing sci-fi experience','2025-10-06 08:00:00'),
(2,4,4,'Great effects','2025-02-02 09:00:00'),
(3,2,3,'Good action scenes','2024-01-06 10:00:00'),
(1,4,4,'Enjoyed it','2025-10-12 12:00:00'),
(4,6,5,'Loved it','2025-11-02 10:00:00');
