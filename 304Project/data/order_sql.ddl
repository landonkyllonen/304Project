DROP TABLE watches;
DROP TABLE PaymentMethod;
DROP TABLE Shipment;
DROP TABLE Address;
DROP TABLE Receipt;
DROP TABLE Bid;
DROP TABLE Auction;
DROP TABLE Item;
DROP TABLE Ticket;
DROP TABLE Users;

Create Table Users(
	userID VARCHAR (25),
	password VARCHAR (25),
	firstName VARCHAR(30),
	lastName VARCHAR(30),
	email VARCHAR(80),
	DOB DATE,
	bidBalance INT,
	permissions VARCHAR(25),
	PRIMARY KEY (userID)
);

Create Table Ticket (
	ticketID INT,
	dateCreated DATETIME,
	category VARCHAR(30),
	content VARCHAR(500),
	userID VARCHAR (25),
	modID VARCHAR (25),
	PRIMARY KEY (ticketID),
	FOREIGN Key (userID) REFERENCES Users (userID)	
);

Create Table Item (
	itemNo INT,
	name VARCHAR(30),
	description VARCHAR(100),
	image INT,
	category VARCHAR(30),
	PRIMARY KEY (itemNo)
);

Create Table Auction (
	auctionID INT,
	startDate DATE,
	endDate DATE,
	currentPrice Decimal (10,2),
	itemNo INT,
	seller VARCHAR (25),
	winner VARCHAR (25),
	PRIMARY KEY (auctionID),
	FOREIGN KEY (seller) 
REFERENCES Users(userID)
ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (winner) 
REFERENCES Users(userID)
ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (itemNo) 
REFERENCES Item(itemNo)
ON UPDATE CASCADE ON DELETE NO ACTION
);

Create Table Bid (
	bidNum INT,
	date DATE,
	auctionID INT,
	PRIMARY KEY (bidNum),
	FOREIGN KEY (auctionID) 
REFERENCES Auction(auctionID)
ON UPDATE CASCADE ON DELETE NO ACTION
);

Create Table Receipt(
	invoiceNo INT,
	auctionID INT,
	finalSalesPercentage Decimal (2,2),
	auctionFee Decimal (5,2),
	collected Decimal (5,2),
	PRIMARY KEY (invoiceNo),
	FOREIGN KEY (auctionID) 
REFERENCES Auction(auctionID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

Create Table Address(
	addressID INT,
	userID VARCHAR (25),
	type VARCHAR(15),
	addressLineone VARCHAR(50),
	addressLinetwo VARCHAR(50),
	city VARCHAR(30),
	provstate VARCHAR(50),
	country VARCHAR(25),
	zippostal VARCHAR(10),
	PRIMARY KEY(addressID),
	FOREIGN KEY (userID) 
REFERENCES Users(userID)
ON UPDATE CASCADE ON DELETE NO ACTION
);

Create Table Shipment(
	shipmentID INT,
	auctionID INT,
	name VARCHAR(50),
	cost Decimal (5,2),
	destination INT,
	origination INT,
	shippingType VARCHAR(30),
	trackingID CHAR (30),
	shipDate DATE,
	confirmDate DATE,
	PRIMARY KEY (shipmentID),
	FOREIGN KEY(origination)
		REFERENCES Address(addressID)
		ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(destination)
		REFERENCES Address(addressID)
		ON UPDATE NO ACTION ON DELETE NO ACTION
);

Create Table PaymentMethod(
	userID VARCHAR (25),
	auctionID INT,
	name VARCHAR(30),
	description VARCHAR(100),
	surcharge Decimal (5,2),
	confirmDate DATE,
	FOREIGN KEY (auctionID) 
REFERENCES Auction(auctionID)
ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (userID) 
REFERENCES Users(userID)
ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE watches(
userID VARCHAR(25),
auctionID INT,
PRIMARY KEY(userID, auctionID),
FOREIGN KEY (userID) 
REFERENCES Users(userID)
ON UPDATE NO ACTION ON DELETE NO ACTION,
FOREIGN KEY (auctionID) 
REFERENCES Auction(auctionID)
ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT Item VALUES(1,'Galaxy S2', 'Stock Phone Details', 1, 'Electronics');
INSERT Item VALUES(2, 'Android Charge Cable', 'Quick charging', 2, 'Electronics');
INSERT Item VALUES(3, 'Gold Watch','14k Gold', 3, 'Jewelry');
INSERT Item VALUES(4, 'Womens Necklace', 'Sterling Silver', 4, 'Jewelry');
INSERT Item VALUES(5, 'Diamond ring','Diamonds', 5, 'Jewelry');
INSERT Item VALUES(6, 'Gold Ring','Gold', 6, 'Jewelry');
INSERT Item VALUES(7, 'Gold Bar','Gold', 7, 'Jewelry');
INSERT Item VALUES(8, 'Gold Toilet','Gold', 8, 'Jewelry');
INSERT Item VALUES(9, 'Gold Foil','Gold', 9, 'Jewelry');
INSERT Item VALUES(10, 'Gold Wire','Gold', 10, 'Jewelry');
INSERT Item VALUES(11, 'Gold Tooth','Gold', 11, 'Jewelry');
INSERT Item VALUES(12, 'Gold Chain','Gold', 12, 'Jewelry');
INSERT Item VALUES(13, 'Smart watch','pretty cool', 13, 'Electronics');
INSERT Item VALUES(14, 'Drone','Spy drone', 14, 'Electronics');
INSERT Item VALUES(15, 'Pebble Qi Charger','wireless', 15, 'Electronics');
INSERT Item VALUES(16, 'Alarm Clock', 'cant wake up', 16, 'Electronics');
INSERT Item VALUES(17, 'Golf balls','hit em', 17, 'Sports');
INSERT Item VALUES(18, 'Golf clubs','use em for the balls', 18, 'Sports');
INSERT Item VALUES(19, 'Soccer Ball','kick it', 19, 'Sports');
INSERT Item VALUES(20, 'Volleyball Net','For volleyball', 20, 'Sports');
INSERT Item VALUES(21, 'Badminton Set','For badminton', 21, 'Sports');
INSERT Item VALUES(22, 'Yoga mat','for yoga', 22, 'Sports');
INSERT Item VALUES(23, 'Skis','for skiing', 23, 'Sports');
INSERT Item VALUES(24, 'Ski Poles','for skis', 24, 'Sports');
INSERT Item VALUES(25, 'Boxing Gloves','punch people with them', 25, 'Sports');
INSERT Item VALUES(26, 'Blush','for your face', 26, 'Cosmetics');
INSERT Item VALUES(27, 'Eyeliner','also for your face', 27, 'Cosmetics');
INSERT Item VALUES(28, 'Foundation','also for your face', 28, 'Cosmetics');
INSERT Item VALUES(29, 'Brush Set','for makeup application', 29, 'Cosmetics');
INSERT Item VALUES(30, 'Trowel','for gardening', 30, 'Home&Garden');
INSERT Item VALUES(31, 'Wire Fencing','for gardening', 31, 'Home&Garden');
INSERT Item VALUES(32, 'Watering Can','for gardening', 32, 'Home&Garden');
INSERT Item VALUES(33, 'Hose','30ft', 33, 'Home&Garden');
INSERT Item VALUES(34, 'Harry Potter and the Treacherous Crawlspace','Best Seller', 34, 'Books');
INSERT Item VALUES(35,'Grandma''s Boysenberry Spread','Tasty', 35,'Food');
INSERT Item VALUES(36,'Uncle Bob''s Organic Dried Pears','He just leaves them in his shed', 36,'Food');
INSERT Item VALUES(37,'Northwoods Cranberry Sauce','Personally not a fan', 37,'Food');
INSERT Item VALUES(38,'Mishi Kobe Niku','Meat/Poultry', 38,'Food');
INSERT Item VALUES(39,'Ikura','Seafood', 39, 'Food');
INSERT Item VALUES(40,'Queso Cabrales','Dairy Products', 40,'Food');

INSERT INTO Users VALUES ('landon', 'mypass', 'Landon', 'Kyllonen', 'LandonKyllonen@hotmail.com','1993-05-06', 100);
INSERT INTO Users VALUES ('matt', 'mypass', 'Landon', 'Kyllonen', 'someemail1@hotmail.com','1993-05-06', 100);
INSERT INTO Users VALUES ('zifang', 'mypass', 'Landon', 'Kyllonen', 'someemail2@hotmail.com','1993-05-06', 100);
INSERT INTO Users VALUES ('russell', 'mypass', 'Landon', 'Kyllonen', 'someemail3@hotmail.com','1993-05-06', 100);
INSERT INTO Users VALUES ('randomuser', 'password1', 'bob', 'loblaw', 'sadas@hotmail.com','1993-05-06', 20);

auctionID INT,
	startDate DATE,
	endDate DATE,
	currentPrice Decimal (10,2),
	itemNo INT,
	seller VARCHAR (25),
	winner VARCHAR (25),
	
INSERT INTO Auction VALUES(1, '2016-11-27','2016-12-08', 5,  1, 'none','none');
INSERT INTO Auction VALUES(2, '2016-11-27','2016-12-08', 7,  1, 'none','none');
INSERT INTO Auction VALUES(3, '2016-11-27','2016-12-08', 8.45,  2, 'none','none');
INSERT INTO Auction VALUES(4, '2016-11-27','2016-12-08', 5.23,  3, 'none','none');
INSERT INTO Auction VALUES(5, '2016-11-27','2016-12-08', 4.25,  4, 'none','none');
INSERT INTO Auction VALUES(6, '2016-11-27','2016-12-08', 5.25,  4, 'none','none');
INSERT INTO Auction VALUES(7, '2016-11-27','2016-12-08', 1.52,  4, 'none','none');
INSERT INTO Auction VALUES(8, '2016-11-27','2016-12-08', 1.23,  5, 'none','none');
INSERT INTO Auction VALUES(9, '2016-11-27','2016-12-08', 1.63,  6, 'none','none');
INSERT INTO Auction VALUES(10, '2016-11-27','2016-12-08', 1.74,  7, 'none','none');
INSERT INTO Auction VALUES(11, '2016-11-27','2016-12-08', 18.25,  8, 'none','none');
INSERT INTO Auction VALUES(12, '2016-11-27','2016-12-08', 4.25,  9, 'none','none');
INSERT INTO Auction VALUES(13, '2016-11-27','2016-12-08', 3.25,  10, 'none','none');
INSERT INTO Auction VALUES(14, '2016-11-27','2016-12-08', 2.75,  11, 'none','none');
INSERT INTO Auction VALUES(15, '2016-11-27','2016-12-08', 1.25,  12, 'none','none');
INSERT INTO Auction VALUES(16, '2016-11-27','2016-12-08', 18.25,  13, 'none','none');
INSERT INTO Auction VALUES(17, '2016-11-27','2016-12-08', 1.75,  14, 'none','none');
INSERT INTO Auction VALUES(18, '2016-11-27','2016-12-08', 18.25,  15, 'none','none');
INSERT INTO Auction VALUES(19, '2016-11-27','2016-12-08', 5.25,  16, 'none','none');
INSERT INTO Auction VALUES(20, '2016-11-27','2016-12-08', 4.54,  17, 'none','none');
INSERT INTO Auction VALUES(21, '2016-11-27','2016-12-08', 18.25,  18, 'none','none');
INSERT INTO Auction VALUES(22, '2016-11-27','2016-12-08', 18.75,  19, 'none','none');
INSERT INTO Auction VALUES(23, '2016-11-27','2016-12-08', 18.25,  20, 'none','none');
INSERT INTO Auction VALUES(24, '2016-11-27','2016-12-08', 1.23,  21, 'none','none');
INSERT INTO Auction VALUES(25, '2016-11-27','2016-12-08', 5.36,  22, 'none','none');
INSERT INTO Auction VALUES(26, '2016-11-27','2016-12-08', 18.75,  23, 'none','none');
INSERT INTO Auction VALUES(27, '2016-11-27','2016-12-08', 18.25,  24, 'none','none');
INSERT INTO Auction VALUES(28, '2016-11-27','2016-12-08', 18.53,  25, 'none','none');
INSERT INTO Auction VALUES(29, '2016-11-27','2016-12-08', 18.25,  26, 'none','none');
INSERT INTO Auction VALUES(30, '2016-11-27','2016-12-08', 18.53,  27, 'none','none');
INSERT INTO Auction VALUES(31, '2016-11-27','2016-12-08', 7.58,  28, 'none','none');
INSERT INTO Auction VALUES(32, '2016-11-27','2016-12-08', 9.54,  29, 'none','none');
INSERT INTO Auction VALUES(33, '2016-11-27','2016-12-08', 0.55,  30, 'none','none');
INSERT INTO Auction VALUES(34, '2016-11-27','2016-12-08', 0.25,  30, 'none','none');
INSERT INTO Auction VALUES(35, '2016-11-27','2016-12-08', 0.63,  30, 'none','none');
INSERT INTO Auction VALUES(36, '2016-11-27','2016-12-08', 0.25,  31, 'none','none');
INSERT INTO Auction VALUES(37, '2016-11-27','2016-12-08', 0.64,  32, 'none','none');
INSERT INTO Auction VALUES(38, '2016-11-27','2016-12-08', 0.25,  32, 'none','none');
INSERT INTO Auction VALUES(39, '2016-11-27','2016-12-08', 0.64,  32, 'none','none');
INSERT INTO Auction VALUES(40, '2016-11-27','2016-12-08', 0.25,  32, 'none','none');
INSERT INTO Auction VALUES(41, '2016-11-27','2016-12-08', 0.62,  32, 'none','none');
INSERT INTO Auction VALUES(42, '2016-11-27','2016-12-08', 0.53,  32, 'none','none');
INSERT INTO Auction VALUES(43, '2016-11-27','2016-12-08', 18.25,  32, 'none','none');
INSERT INTO Auction VALUES(44, '2016-11-27','2016-12-08', 1.32,  32, 'none','none');
INSERT INTO Auction VALUES(45, '2016-11-27','2016-12-08', 1.54,  33, 'none','none');
INSERT INTO Auction VALUES(46, '2016-11-27','2016-12-08', 1.25,  33, 'none','none');
INSERT INTO Auction VALUES(47, '2016-11-27','2016-12-08', 5.63,  33, 'none','none');
INSERT INTO Auction VALUES(48, '2016-11-27','2016-12-08', 3.42,  34, 'none','none');
INSERT INTO Auction VALUES(49, '2016-11-27','2016-12-08', 5.25,  34, 'none','none');
INSERT INTO Auction VALUES(50, '2016-11-27','2016-12-08', 18.42,  35, 'none','none');
INSERT INTO Auction VALUES(51, '2016-11-27','2016-12-08', 5.25,  36, 'none','none');
INSERT INTO Auction VALUES(52, '2016-11-27','2016-12-08', 18.25,  37, 'none','none');
INSERT INTO Auction VALUES(53, '2016-11-27','2016-12-08', 5.25,  37, 'none','none');
INSERT INTO Auction VALUES(54, '2016-11-27','2016-12-08', 7.42,  37, 'none','none');
INSERT INTO Auction VALUES(55, '2016-11-27','2016-12-08', 7.23,  37, 'none','none');
INSERT INTO Auction VALUES(56, '2016-11-27','2016-12-08', 7.32,  37, 'none','none');
INSERT INTO Auction VALUES(57, '2016-11-27','2016-12-08', 7.63,  5, 'none','none');
INSERT INTO Auction VALUES(58, '2016-11-27','2016-12-08', 1.23,  6, 'none','none');
INSERT INTO Auction VALUES(59, '2016-11-27','2016-12-08', 2.25,  7, 'none','none');
INSERT INTO Auction VALUES(60, '2016-11-27','2016-12-08', 32.25,  8, 'none','none');
INSERT INTO Auction VALUES(61, '2016-11-27','2016-12-08', 2.25,  9, 'none','none');
INSERT INTO Auction VALUES(62, '2016-11-27','2016-12-08', 6.53,  10, 'none','none');
INSERT INTO Auction VALUES(63, '2016-11-27','2016-12-08', 4.53,  11, 'none','none');
INSERT INTO Auction VALUES(64, '2016-11-27','2016-12-08', 2.25,  11, 'none','none');
INSERT INTO Auction VALUES(65, '2016-11-27','2016-12-08', 8.42,  11, 'none','none');
INSERT INTO Auction VALUES(66, '2016-11-27','2016-12-08', 7.25,  38, 'none','none');
INSERT INTO Auction VALUES(67, '2016-11-27','2016-12-08', 4.53,  39, 'none','none');
INSERT INTO Auction VALUES(68, '2016-11-27','2016-12-08', 4.25,  40, 'none','none');

