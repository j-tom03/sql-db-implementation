-- Update 1: increase adult Exeter food festival tickets by 100
UPDATE TicketTypes
SET quantityAvailable = quantityAvailable + 100
WHERE eventID = 1
AND ticketTypeID = 1;

-- Update 2: Ian booking for the Exeter food festival with voucher
INSERT INTO Bookings(customerID, eventID, cost, paymentConfirmed, paymentID, discountCode, bookingTime, emailTickets)
VALUES (4, 1, 22.5, true, 3, "FOOD10", NOW(), true); 
INSERT INTO TicketOnBookings(bookingReference, ticketTypeID, quantity)
VALUES (4, 1, 2),
	   (4, 2, 1);
       
-- Update 3: cancel Joe's booking by booking reference
INSERT IGNORE INTO Cancellations(bookingReference, refundProcessed, refundCardID)
VALUES (4, true, 2);
DELETE FROM TicketOnBookings WHERE bookingReference=4;
DELETE FROM Bookings WHERE bookingReference=4;

-- Update 4: add code to the Exmouth music festival
INSERT IGNORE INTO VoucherCodes(code, discountMultiplier, eventID)
VALUES("SUMMER20", 0.8, 4);
