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
	email VARCHAR(100),
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
	itemNo INT IDENTITY(1,1),
	name VARCHAR(100),
	description VARCHAR(100),
	image VARCHAR(200),
	category VARCHAR(30),
	PRIMARY KEY (itemNo)
);

Create Table Auction (
	auctionID INT IDENTITY(1,1),
	startDate DATETIME,
	endDate DATETIME,
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
	invoiceNo INT IDENTITY(1,1),
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

INSERT Item VALUES('Galaxy S2', 'Stock Phone Details', 1, 'Electronics');
INSERT Item VALUES('Android Charge Cable', 'Quick charging', 2, 'Electronics');
INSERT Item VALUES('Gold Watch','14k Gold', 3, 'Jewelry');
INSERT Item VALUES('Womens Necklace', 'Sterling Silver', 4, 'Jewelry');
INSERT Item VALUES('Diamond ring','Diamonds', 5, 'Jewelry');
INSERT Item VALUES('Gold Ring','Gold', 6, 'Jewelry');
INSERT Item VALUES('Gold Bar','Gold', 7, 'Jewelry');
INSERT Item VALUES('Gold Toilet','Gold', 8, 'Jewelry');
INSERT Item VALUES('Gold Foil','Gold', 9, 'Jewelry');
INSERT Item VALUES('Gold Wire','Gold', 10, 'Jewelry');
INSERT Item VALUES('Gold Tooth','Gold', 11, 'Jewelry');
INSERT Item VALUES('Gold Chain','Gold', 12, 'Jewelry');
INSERT Item VALUES('Smart watch','pretty cool', 13, 'Electronics');
INSERT Item VALUES('Drone','Spy drone', 14, 'Electronics');
INSERT Item VALUES('Pebble Qi Charger','wireless', 15, 'Electronics');
INSERT Item VALUES('Alarm Clock', 'cant wake up', 16, 'Electronics');
INSERT Item VALUES('Golf balls','hit em', 17, 'Sports');
INSERT Item VALUES('Golf clubs','use em for the balls', 18, 'Sports');
INSERT Item VALUES('Soccer Ball','kick it', 19, 'Sports');
INSERT Item VALUES('Volleyball Net','For volleyball', 20, 'Sports');
INSERT Item VALUES('Badminton Set','For badminton', 21, 'Sports');
INSERT Item VALUES('Yoga mat','for yoga', 22, 'Sports');
INSERT Item VALUES('Skis','for skiing', 23, 'Sports');
INSERT Item VALUES('Ski Poles','for skis', 24, 'Sports');
INSERT Item VALUES('Boxing Gloves','punch people with them', 25, 'Sports');
INSERT Item VALUES('Blush','for your face', 26, 'Cosmetics');
INSERT Item VALUES('Eyeliner','also for your face', 27, 'Cosmetics');
INSERT Item VALUES('Foundation','also for your face', 28, 'Cosmetics');
INSERT Item VALUES('Brush Set','for makeup application', 29, 'Cosmetics');
INSERT Item VALUES('Trowel','for gardening', 30, 'Home&Garden');
INSERT Item VALUES('Wire Fencing','for gardening', 31, 'Home&Garden');
INSERT Item VALUES('Watering Can','for gardening', 32, 'Home&Garden');
INSERT Item VALUES('Hose','30ft', 33, 'Home&Garden');
INSERT Item VALUES('Harry Potter and the Treacherous Crawlspace','Best Seller', 34, 'Books');
INSERT Item VALUES('Grandma''s Boysenberry Spread','Tasty', 35,'Food');
INSERT Item VALUES('Uncle Bob''s Organic Dried Pears','He just leaves them in his shed', 36,'Food');
INSERT Item VALUES('Northwoods Cranberry Sauce','Personally not a fan', 37,'Food');
INSERT Item VALUES('Mishi Kobe Niku','Meat/Poultry', 38,'Food');
INSERT Item VALUES('Ikura','Seafood', 39, 'Food');
INSERT Item VALUES('Queso Cabrales','Dairy Products', 40,'Food');

INSERT INTO Users VALUES ('landon', 'mypass', 'Landon', 'Kyllonen', 'LandonKyllonen@hotmail.com','1993-05-06', 100, 'admin');
INSERT INTO Users VALUES ('matt', 'mypass', 'Landon', 'Kyllonen', 'someemail1@hotmail.com','1993-05-06', 100, 'admin');
INSERT INTO Users VALUES ('zifang', 'mypass', 'Landon', 'Kyllonen', 'someemail2@hotmail.com','1993-05-06', 100, 'admin');
INSERT INTO Users VALUES ('russell', 'mypass', 'Landon', 'Kyllonen', 'someemail3@hotmail.com','1993-05-06', 100, 'admin');
INSERT INTO Users VALUES ('randomuser', 'password1', 'bob', 'loblaw', 'sadas@hotmail.com','1993-05-06', 20, 'user');
	
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5,  1, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7,  1, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 8.45,  2, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.23,  3, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 4.25,  4, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.25,  4, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.52,  4, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.23,  5, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.63,  6, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.74,  7, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  8, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 4.25,  9, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 3.25,  10, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 2.75,  11, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.25,  12, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  13, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.75,  14, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  15, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.25,  16, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 4.54,  17, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  18, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.75,  19, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  20, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.23,  21, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.36,  22, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.75,  23, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  24, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.53,  25, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  26, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.53,  27, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7.58,  28, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 9.54,  29, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.55,  30, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.25,  30, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.63,  30, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.25,  31, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.64,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.25,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.64,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.25,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.62,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 0.53,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.32,  32, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.54,  33, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.25,  33, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.63,  33, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 3.42,  34, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.25,  34, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.42,  35, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.25,  36, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 18.25,  37, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 5.25,  37, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7.42,  37, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7.23,  37, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7.32,  37, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7.63,  5, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 1.23,  6, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 2.25,  7, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 32.25,  8, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 2.25,  9, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 6.53,  10, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 4.53,  11, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 2.25,  11, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 8.42,  11, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 7.25,  38, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 4.53,  39, 'landon',NULL);
INSERT INTO Auction (startDate, endDate, currentPrice, itemNo, seller, winner) VALUES('2016-11-27','2016-12-08', 4.25,  40, 'landon',NULL);