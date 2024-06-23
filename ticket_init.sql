DROP DATABASE IF EXISTS booking_events;
CREATE DATABASE IF NOT EXISTS booking_events;
USE booking_events;

DROP TABLE IF EXISTS TicketOnBookings;
DROP TABLE IF EXISTS Cancellations;
DROP TABLE IF EXISTS TicketTypes;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS PaymentInformation;
DROP TABLE IF EXISTS VoucherCodes;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
	customerID int NOT NULL auto_increment PRIMARY KEY,
    fullName varchar(255),
    address varchar(255),
    contactNumber varchar(13),
    emailAddress varchar(255)
);

CREATE TABLE Events (
	eventID int NOT NULL auto_increment PRIMARY KEY,
    title varchar(255),
    description varchar(511),
    venue varchar(255),
    eventType varchar(255),
    startDateTime datetime,
    endDateTime datetime
);

CREATE TABLE VoucherCodes(
	code varchar(255) NOT NULL PRIMARY KEY,
    discountMultiplier double,
    eventID int,
    FOREIGN KEY (eventID) REFERENCES Events(eventID)
);

CREATE TABLE PaymentInformation (
	paymentID int NOT NULL auto_increment PRIMARY KEY,
    cardType varchar(255),
    cardNumber varchar(255),
    securityCode varchar(3),
    expiryDate DATE, 
    cardHolderID int,
    FOREIGN KEY (cardHolderID) REFERENCES Customers(customerID)
);

CREATE TABLE Bookings (
	bookingReference int NOT NULL auto_increment PRIMARY KEY,
    customerID int,
    eventID int,
    cost double,
    paymentConfirmed boolean,
    paymentID int,
    discountCode varchar(255),
    bookingTime datetime,
    emailTickets boolean,
    FOREIGN KEY (discountCode) REFERENCES VoucherCodes(code),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID),
    FOREIGN KEY (eventID) REFERENCES Events(eventID),
    FOREIGN KEY (paymentID) REFERENCES PaymentInformation(paymentID)
);

CREATE TABLE TicketTypes (
	ticketTypeID int NOT NULL auto_increment PRIMARY KEY,
	title varchar(255),
    description varchar(511),
    price double,
    quantityAvailable int,
    eventID int,
    FOREIGN KEY (eventID) REFERENCES Events(eventID)
);

CREATE TABLE Cancellations (
	bookingReference int NOT NULL PRIMARY KEY,
    refundProcessed boolean,
    refundCardID int,
    FOREIGN KEY (refundCardID) REFERENCES PaymentInformation(paymentID)
);

CREATE TABLE TicketOnBookings (
	bookingReference int,
    ticketTypeID int,
    quantity int NOT NULL,
    FOREIGN KEY (bookingReference) REFERENCES Bookings(bookingReference),
    FOREIGN KEY (ticketTypeID) REFERENCES TicketTypes(ticketTypeID)
);

INSERT INTO Customers(fullName, address, contactNumber, emailAddress)
VALUES ("Bob Bobberson", "Bob Road, Plymouth", "+447000010000", "bob@plymouthmail.com"), -- ID 1
	   ("Jim Johnson", "Jim Avenue, Barnstaple", "+447000020000", "jim@barnmail.com"), -- ID 2
       ("Sandy Sanderton", "Sandy Street, Crediton", "+447000030000", "sandy@credmed.com"), -- ID 3
       ("Ian Cooper", "Ian Rise, Exmouth", "+447000002000", "ian@exmail.com"), -- ID 4
       ("Joe Smiths", "Joe Alley, Dawlish", "+447000024000", "joe@dawmail.com"); -- ID 5

INSERT INTO Events(title, description, venue, eventType, startDateTime, endDateTime)
VALUES ("Exeter Food Festival 2023", "food festival", "Exeter", "Festival", '2023-07-05 12:00:00', '2023-07-05 18:00:00'), -- ID 1
	   ("Rock and Roll Party", "Rock Party", "Exeter", "Party", '2023-07-02 18:00:00', '2023-07-02 22:00:00'), -- ID 2
       ("Comedy Show", "comedy show", "Exeter", "stage show", '2023-06-21 20:00:00', '2023-06-21 21:30:00'), -- ID 3
       ("Exmouth Music Festival 2023", "music festival", "Exmouth", "Festival", '2023-10-29 15:00:00', '2023-10-29 21:30:00'), -- ID 4
       ("Bad Event", "an event that wont take place", "Not Here", "Event", '2023-12-12 15:00:00', '2023-12-12 17:00:00'); -- ID 5

INSERT INTO TicketTypes(title, description, price, quantityAvailable, eventID)
VALUES ("Adult Ticket", "16 years and over", 10.00, 100, 1), -- ID 1
	   ("Child Ticket", "Ages 5 to 15", 5.00, 50, 1), -- ID 2
       ("Bronze", "bronze package", 15.00, 300, 4), -- ID 3
       ("Silver", "silver package", 27.50, 200, 4), -- ID 4
       ("Gold", "gold vip package", 45.99, 150, 4), -- ID 5
       ("Spectator", "for spectators", 25.00, 400, 2), -- ID 6
       ("Performer", "for performer", 1.00, 10, 2), -- ID 7
       ("General", "general admission", 5.00, 200, 5); -- ID 8
       
INSERT INTO PaymentInformation(cardType, cardNumber, securityCode, expiryDate, cardHolderID)
VALUES ("Visa", "123456789", "123", '2027-12-12', 1), -- ID 1
	   ("Mastercard", "987654321", "987", '2029-09-03', 2), -- ID 2
       ("Credit Card", "123212321", "543", '2025-01-04', 4); -- ID 3

       
INSERT INTO Bookings(customerID, eventID, cost, paymentConfirmed, paymentID, bookingTime, emailTickets)
VALUES (1, 4, 450, true, 1, '2023-01-29 15:00:00', true), -- ID 1
	   (2, 4, 300, true, 2, '2023-01-04 16:00:00', false), -- ID 2
       (1, 2, 175, true, 1, '2023-02-21 11:15:00', false), -- ID 3
       (5, 5, 10, true, 2, '2023-02-21 11:15:00', false); -- ID 4
       
INSERT INTO TicketOnBookings(bookingReference, ticketTypeID, quantity)
VALUES (1, 5, 3),
	   (2, 5, 2),
       (3, 6, 7),
       (4, 8, 2);
       
INSERT INTO VoucherCodes(code, discountMultiplier, eventID)
VALUES ("FOOD10", 0.9, 1);


