DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS RideOperator;
DROP TABLE IF EXISTS RideTicket;
DROP TABLE IF EXISTS PlayActor;
DROP TABLE IF EXISTS PlayTicket;
DROP TABLE IF EXISTS Play;
DROP TABLE IF EXISTS FoodStallWorker;
DROP TABLE IF EXISTS MenuItem;
DROP TABLE IF EXISTS FoodStall;
DROP TABLE IF EXISTS Stage;
DROP TABLE IF EXISTS Ride;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Employee;


CREATE TABLE Employee (
    ID INT NOT NULL,
    Name VARCHAR(128) NOT NULL,
    Role VARCHAR(64) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Ticket (
    ID INT NOT NULL,
    TimeSold TIME NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE Ride (
    ID INT NOT NULL,
    Name VARCHAR(128),
    TopSpeed DECIMAL(4, 1) NOT NULL, -- km/h
    RunsPerHour INT NOT NULL,
    Price DECIMAL(4, 2) NOT NULL,
    MinHeight INT, -- cm
    MaxHeight INT, -- cm
    PRIMARY KEY (ID)
);

CREATE TABLE Stage (
    ID INT NOT NULL,
    Name VARCHAR(128) NOT NULL,
    NumSeats INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FoodStall (
    ID INT NOT NULL,
    ManagedBy INT NOT NULL,
    Name VARCHAR (128) NOT NULL,
    Cuisine VARCHAR(32) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (ManagedBy) REFERENCES Employee (ID)
);

CREATE TABLE MenuItem (
    ID INT NOT NULL,
    FoodStallID INT NOT NULL,
    Name VARCHAR(64) NOT NULL,
    Price DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (ID, FoodStallID),
    FOREIGN KEY (FoodStallID) REFERENCES FoodStall (ID)
);

CREATE TABLE FoodStallWorker (
    EmployeeID INT NOT NULL,
    FoodStallID INT NOT NULL,
    PRIMARY KEY (EmployeeID, FoodStallID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (ID),
    FOREIGN KEY (FoodStallID) REFERENCES FoodStall (ID)
);

CREATE TABLE Play (
    ID INT NOT NULL,
    StageID INT NOT NULL,
    Name VARCHAR(64) NOT NULL,
    Duration INT NOT NULL, -- minutes
    Genre VARCHAR(32) NOT NULL,
    Price DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (StageID) REFERENCES Stage (ID)
);

CREATE TABLE PlayTicket (
    PlayID INT NOT NULL,
    TicketID INT NOT NULL,
    PRIMARY KEY (PlayID, TicketID),
    FOREIGN KEY (PlayID) REFERENCES Play (ID),
    FOREIGN KEY (TicketID) REFERENCES Ticket (ID)
);

CREATE TABLE PlayActor (
    EmployeeID INT NOT NULL,
    PlayID INT NOT NULL,
    CharacterName VARCHAR(64) NOT NULL,
    PRIMARY KEY (EmployeeID, PlayID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (ID),
    FOREIGN KEY (PlayID) REFERENCES Play (ID)
);

CREATE TABLE RideTicket (
    RideID INT NOT NULL,
    TicketID INT NOT NULL,
    PRIMARY KEY (RideID, TicketID),
    FOREIGN KEY (RideID) REFERENCES Ride (ID),
    FOREIGN KEY (TicketID) REFERENCES Ticket (ID)
);

CREATE TABLE RideOperator (
    EmployeeID INT NOT NULL,
    RideID INT NOT NULL,
    YearsExperienceWithRide INT NOT NULL,
    PRIMARY KEY (EmployeeID, RideID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (ID),
    FOREIGN KEY (RideID) REFERENCES Ride (ID)
);

CREATE TABLE Maintenance (
    ID INT NOT NULL,
    RideID INT NOT NULL,
    PerformedBy INT NOT NULL,
    TimePerformed TIME NOT NULL,
    Note VARCHAR(128) NOT NULL,
    PRIMARY KEY (ID, RideID),
    FOREIGN KEY (RideID) REFERENCES Ride (ID),
    FOREIGN KEY (PerformedBy) REFERENCES Employee (ID)
);

-- Employee (ID, Name, PrimaryRole)
INSERT INTO Employee VALUES
    ( 1, "Susannah",  "Ticket Seller"),
    ( 2, "Jonathan",  "Food Sales"),
    ( 3, "Jennie",    "Food Sales"),
    ( 4, "Wilfred",   "Security"),
    ( 5, "Marcus",    "Food Sales"),
    ( 6, "Franklin",  "Food Sales"),
    ( 7, "Emily",     "Food Sales"),
    ( 8, "Hazel",     "Entertainer"),
    ( 9, "Milton",    "Security"),
    (10, "Samuel",    "Food Sales"),
    (11, "Vanessa",   "Food Sales"),
    (12, "Lester",    "Food Sales"),
    (13, "Cecilia",   "Operator"),
    (14, "Elissa",    "Operator"),
    (15, "Nicholas",  "Entertainer"),
    (16, "Lillian",   "Entertainer"), 
    (17, "Owen",      "Entertainer"), 
    (18, "Mackenzie", "Operator"), 
    (19, "Harry",     "Entertainer"), 
    (20, "Timothy",   "Operator"), 
    (21, "Roosevelt", "Entertainer"), 
    (22, "Michelle",  "Entertainer"), 
    (23, "Matthew",   "Operator"),
    (24, "Bradley",   "Operator"),
    (25, "Vivian",    "Operator"),
    (26, "Brooke",    "Operator"),
    (27, "Wilson",    "Operator"),
    (28, "Rowan",     "Operator");

-- Ride (ID, Name, TopSpeed, RunsPerHour, Price, MinHeight (cm, NULLABLE), MaxHeight (cm, NULLABLE))
INSERT INTO Ride VALUES
    (1, "Coaster of Liberty", 70, 25, 10.99, 140,  NULL),
    (2, "The Hollow Place",   60, 30, 14.00, 130,  NULL),
    (3, "The Pendulum",       60, 20, 12.99, 110,  190),
    (4, "Ferris Wheel",       10, 40,  7.99, NULL, NULL),
    (5, "Carousel",            5, 20,  5.00, NULL, NULL),
    (6, "Dropping Carousel",  70, 10, 13.00, 140,  210),
    (7, "The Crown",          40, 12, 11.99, 100,  NULL);

-- RideOperator (EmployeeID, RideID, YearsExperienceWithRide)
INSERT INTO RideOperator VALUES
    (13, 1, 3),
    (14, 1, 2),
    (13, 2, 1),
    (18, 2, 2),
    (14, 3, 3),
    (20, 3, 0),
    (26, 3, 1),
    (27, 3, 5),
    (20, 4, 2),
    (24, 4, 2),
    (23, 5, 7),
    (24, 6, 3),
    (25, 6, 1),
    (26, 6, 4),
    (28, 7, 2);

-- Maintenance (ID, RideID, PerformedBy, TimePerformed, Note (NULLABLE))
INSERT INTO Maintenance VALUES
    (1, 1, 13, '13:35:00', "Lubrication"),
    (2, 1, 14, '14:56:00', "Inspect rattling noise"),
    (3, 1,  2, '15:10:00', "Secure rail with tape"),
    (4, 1, 14, '15:54:00', "Inspect and repair brake failure"),
    (1, 2, 18, '13:40:00', "Verify operating specifications"),
    (2, 2, 18, '15:05:00', "Lubrication and visual inspection"),
    (1, 5, 23, '13:45:00', "Calibrate/verify rotation speed"),
    (2, 5, 23, '15:00:00', "Calibrate/verify rotation speed"),
    (1, 6, 25, '13:30:00', "Test braking system"),
    (1, 7, 28, '13:35:00', "Test lights"),
    (2, 7, 28, '13:35:00', "Test braking system");

-- Stage (ID, Name, NumSeats)
INSERT INTO Stage VALUES
    (1, "The Medieval",  85),
    (2, "Kids Stage",    60),
    (3, "Cost Theatre",  90),
    (4, "Raffi's Stage", 120);

-- FoodStall (ID, ManagedBy, Name, Cuisine, PhoneNumber)
INSERT INTO FoodStall VALUES
    (1,  2, "Tasty Trolley",   "Dessert",  "920202020"),
    (2,  5, "Shawarma Kebabs", "Turkish",  "984820122"),
    (3, 11, "Gourmet Grill",   "American", "918580928");

-- MenuItem (ID, FoodStallID, Name, Price)
INSERT INTO MenuItem VALUES
    (1, 1, "Ice-Cream",        5.5),
    (2, 1, "Sorbet",           5.1),
    (3, 1, "Gelato",           5.5),
    (4, 1, "Waffle",           6),
    (5, 1, "Pancake",          5),
    (6, 1, "Milkshake",        6),
    (7, 1, "Soft Drink",       4),
    (1, 2, "Kebab Roll",       11),
    (2, 2, "Kebab Plate",      15),
    (3, 2, "Burger",           11),
    (4, 2, "Small Snack Pack", 10),
    (5, 2, "Large Snack Pack", 16),
    (6, 2, "Small Fries",      6),
    (7, 2, "Large Fries",      9),
    (1, 3, "Burger",           12),
    (2, 3, "Sandwich",         11),
    (3, 3, "Small Fries",      5),
    (4, 3, "Large Fries",      8),
    (5, 3, "Onion Rings",      6),
    (6, 3, "Steak",            13),
    (7, 3, "Pot Coffee",       4),
    (8, 3, "Hotdog",           4);

-- FoodStallWorker (EmployeeID, FoodStallID)
INSERT INTO FoodStallWorker VALUES
    ( 2, 1),
    ( 3, 1),
    ( 5, 2),
    ( 6, 2),
    ( 7, 2),
    (11, 3),
    (10, 3),
    (12, 3);

-- Play (ID, StageID, Name, Duration, Genre, Price)
INSERT INTO Play VALUES
    (1, 1, "Kings Servants",      22, "Drama", 15.5),
    (2, 1, "The Glass",           15, "Drama", 14.99),
    (3, 2, "Fiona and the Frog",  20, "Kids", 10.99),
    (4, 2, "Arachnid Man",        19, "Kids", 10.5);

-- PlayActor (EmployeeID, PlayID, CharacterName)
INSERT INTO PlayActor VALUES
    ( 8, 1, "Alana"),
    ( 8, 2, "Julia"),
    ( 8, 3, "Isla"),
    (15, 1, "Kurtis"),
    (15, 3, "Harry"),
    (15, 4, "Umar"),
    (16, 3, "Nora"),
    (16, 4, "Louise"),
    (17, 3, "Sean"),
    (17, 4, "Marvin"),
    (19, 2, "Joseph"),
    (19, 4, "Alvin"),
    (21, 1, "Dale"),
    (21, 2, "Harriet");

-- Ticket (ID, TimeSold)
INSERT INTO Ticket VALUES
    ( 1, '14:02:00'),
    ( 2, '14:06:00'),
    ( 3, '14:06:00'),
    ( 4, '14:08:00'),
    ( 5, '14:10:00'),
    ( 6, '14:10:00'),
    ( 7, '14:11:00'),
    ( 8, '14:16:00'),
    ( 9, '14:17:00'),
    (10, '14:17:00'),
    (11, '14:20:00'),
    (12, '14:21:00'),
    (13, '14:26:00'),
    (14, '14:28:00'),
    (15, '14:30:00'),
    (16, '14:33:00'),
    (17, '14:37:00'),
    (18, '14:40:00'),
    (19, '14:43:00'),
    (20, '14:44:00'),
    (21, '14:44:00'),
    (22, '14:49:00'),
    (23, '14:51:00'),
    (24, '14:51:00'),
    (25, '14:55:00'),
    (26, '14:58:00'),
    (27, '15:00:00'),
    (28, '15:01:00'),
    (29, '15:01:00'),
    (30, '15:04:00'),
    (31, '15:05:00'),
    (32, '15:07:00'),
    (33, '15:09:00'),
    (34, '15:10:00'),
    (35, '15:10:00'),
    (36, '15:11:00'),
    (37, '15:17:00'),
    (38, '15:18:00'),  
    (39, '15:24:00'), 
    (40, '15:27:00'),
    (41, '15:27:00'),
    (42, '15:30:00'),
    (43, '15:31:00'),
    (44, '15:35:00'), 
    (45, '15:36:00'),
    (46, '15:36:00'),
    (47, '15:36:00'),
    (48, '15:40:00'), 
    (49, '15:40:00'),
    (50, '15:44:00'),
    (51, '15:47:00'),
    (52, '15:50:00'),
    (53, '15:50:00'),
    (54, '15:50:00'),
    (55, '15:50:00'),
    (56, '15:53:00'),
    (57, '15:57:00'),
    (58, '15:58:00'),
    (59, '16:01:00'),
    (60, '16:01:00'),
    (61, '16:06:00'),
    (62, '16:08:00'),
    (63, '16:09:00'),
    (64, '16:10:00'),
    (65, '16:13:00'),
    (66, '16:14:00'),
    (67, '16:17:00'),
    (68, '16:18:00'),
    (69, '16:20:00'),
    (70, '16:21:00'),
    (71, '16:21:00'),
    (72, '16:24:00'),
    (73, '16:24:00'),
    (74, '16:28:00'),
    (75, '16:30:00'),
    (76, '16:31:00'),
    (77, '16:35:00'),
    (78, '16:37:00'),
    (79, '16:37:00'),
    (80, '16:39:00'),
    (81, '16:40:00'),
    (82, '16:44:00'),
    (83, '16:46:00'),
    (84, '16:48:00'),
    (85, '16:49:00'),
    (86, '16:53:00'),
    (87, '16:55:00'),
    (88, '16:55:00'),
    (89, '16:58:00'),
    (90, '16:59:00');

-- PlayTicket (PlayID, TicketID)
INSERT INTO PlayTicket VALUES
    (3, 5),
    (3, 6),
    (3, 7),
    (2, 11),
    (2, 12),
    (1, 14),
    (1, 15),
    (1, 17),
    (4, 19),
    (4, 20),
    (4, 21),
    (1, 22),
    (2, 30),
    (2, 31),
    (1, 34),
    (1, 35),
    (1, 36),
    (4, 37),
    (4, 38),
    (4, 44),
    (3, 48),
    (3, 49),
    (1, 51),
    (1, 52),
    (1, 53),
    (1, 54),
    (1, 55),
    (2, 57),
    (2, 58),
    (3, 62),
    (3, 63),
    (3, 64),
    (1, 68),
    (1, 72),
    (1, 73),
    (2, 77),
    (4, 80),
    (4, 81),
    (2, 85),
    (1, 86),
    (2, 89),
    (2, 90);

-- RideTicket (RideID, TicketID)
INSERT INTO RideTicket VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (7, 4),
    (6, 8),
    (6, 9),
    (6, 10),
    (5, 13),
    (3, 15),
    (3, 16),
    (2, 18),
    (2, 23),
    (2, 24),
    (5, 25),
    (2, 26),
    (4, 27),
    (4, 28),
    (4, 29),
    (1, 32),
    (1, 33),
    (7, 39),
    (6, 40),
    (6, 41),
    (4, 42),
    (4, 43),
    (2, 45),
    (2, 46),
    (2, 47),
    (1, 50),
    (1, 56),
    (2, 59),
    (2, 60),
    (1, 61),
    (3, 65),
    (3, 66),
    (6, 67),
    (6, 68),
    (7, 69),
    (7, 70),
    (7, 71),
    (5, 74),
    (6, 75),
    (6, 76),
    (4, 78),
    (4, 79),
    (1, 82),
    (2, 83),
    (3, 84),
    (1, 87),
    (1, 88);
    

/*Write a query that finds the name of all food stalls as well as the number of food stall workers that work at each stall. Only food stalls with exactly 3 workers should be shown.
*/

SELECT Foodstall.Name, Count(foodstallworker.EmployeeID) AS 'Number of workers'
FROM foodstall
JOIN foodstallworker
ON foodstall.ID = foodstallworker.FoodStallID
GROUP BY foodstall.ID
HAVING Count(foodstallworker.EmployeeID) =3; 

/* Write a query that finds employees that work at a foodstall with "grill" in the same*/

SELECT name, employeeID
FROM foodstall
WHERE Name LIKE '%Grill%';


/* show the emloyee ids with more that 2 years of experience in descending order*/

SELECT EmployeeID, YearsExperienceWithRide
FROM rideoperator
WHERE YearsExperienceWithRide > 2
ORDER BY YearsExperienceWithRide DESC;

/* Show foodstalls with a space in their name*/
SELECT Name, Cuisine
FROM foodstall
WHERE Name LIKE '% %'
Order by Name DESC;

/* Question: List all food stalls along with the names of their workers. */

SELECT foodstall.Name AS FoodStallName, employee.Name AS WorkerName
FROM foodstall
JOIN foodstallworker ON foodstall.ID = foodstallworker.FoodStallID
JOIN employee ON foodstallworker.EmployeeID = employee.ID;

/* ride and ride operator with their amount of experience*/

SELECT ride.Name AS RideName, employee.Name AS 'Employee Name', rideoperator.YearsExperienceWithRide
FROM ride
JOIN rideoperator ON ride.ID = rideoperator.RideID
JOIN employee ON rideoperator.EmployeeID = employee.ID
WHERE rideoperator.YearsExperienceWithRide > 2
ORDER BY rideoperator.YearsExperienceWithRide DESC ;


/*Find the total number of workers at each food stall.*/

SELECT foodstall.name, COUNT(foodstallworker.EmployeeID) AS 'Number of Workers'
FROM foodstall
JOIN foodstallworker
ON foodstall.ID = foodstallworker.FoodStallID
GROUP BY foodstall.name;

/* foodstalls  with examply 4 workers*/
SELECT foodstall.name, COUNT(foodstallworker.EmployeeID) AS 'Number of Workers'
FROM foodstall
JOIN foodstallworker
ON foodstall.ID = foodstallworker.FoodStallID
GROUP BY foodstall.name
HAVING COUNT(foodstallworker.EmployeeID) =3;

/* Menu item names with a space*/
SELECT name
FROM menuitem
WHERE name LIKE '% %';

/*average price of menu items with their name*/
SELECT AVG(PRICE)
FROM menuitem;


/* Write a SQL query to find all menu items where the name contains a number. */

SELECT Name
FROM menuitem
WHERE Name LIKE '%[0-9]%';

/* find the ride with the smallest minimum height*/


/*Question: List all food stalls along with the names of their workers.*/

SELECT foodstall.name, Employee.name
FROM foodstall
JOIN foodstallworker ON foodstall.ID = foodstallworker.FoodstalliD
Join Employee ON foodstallworker.EmployeeID = employee.ID
ORDER by Employee.name ;



/*Find the total number of workers at each food stall.*/

SELECT foodstall.name as 'FOODNAME', COUNT(foodstallworker.EmployeeID) AS 'NOW'
FROM foodstall
JOIN foodstallworker
ON foodstall.ID = foodstallworker.FoodStallID
Group by foodstall.ID;

/* Find the order of rides by topspeed in ascending order*/
SELECT name, topspeed
FROM ride
Order by topspeed asc
Limit 1;

/* Find the lowest priced foodttall menu item */
SELECT foodstall.Name, min(menuitem.Price) AS lowest_price
FROM foodstall
JOIN menuitem ON foodstall.ID = menuitem.FoodStallID
GROUP BY foodstall.Name;

/* Find the highest priced foodstall menu item */
SELECT foodstall.name, max(menuitem.price)
FROM foodstall
Join menuitem ON foodstall.id = menuitem.foodstallid
group by foodstall.id;
