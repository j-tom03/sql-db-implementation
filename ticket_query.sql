USE booking_events;

-- Query 1: getting information about Exeter Food Festival
SELECT e.title AS Title, e.venue AS Location, e.description AS Description, e.startDateTime AS "Start Time", e.endDateTime AS "End Time", t.title AS "Ticket Type", t.quantityAvailable AS "Total Quantity"
FROM Events AS e, TicketTypes AS t
WHERE e.title="Exeter Food Festival 2023" AND e.eventID=t.eventID
GROUP BY e.title, e.venue, e.description, e.startDateTime, e.endDateTime, t.title, t.quantityAvailable;

-- Query 2: getting events from 1 to 10 July 2023
SELECT e.title AS Title, e.startDateTime AS "Start Time", e.endDateTime AS "End Time", e.description AS Description
FROM Events AS e
WHERE e.venue="Exeter" 
AND (e.startDateTime BETWEEN '2023-07-01 00:00:00' AND '2023-07-10 23:59:59');

-- Query 3: getting available amount and price for Bronze Exmouth Music tickets
SELECT t.quantityAvailable AS Available, t.price AS "Price £"
FROM TicketTypes AS t, Events AS e
WHERE t.title="Bronze" AND t.eventID=e.eventID 
AND e.title = "Exmouth Music Festival 2023";

-- Query 4: names & quantity of Gold ticket holders to Exmouth Music Festival
SELECT c.fullName AS Name, tob.quantity AS "Number of Gold Tickets"
FROM Customers AS c, TicketOnBookings AS tob, TicketTypes AS tt, Bookings AS b
WHERE tob.ticketTypeID=tt.ticketTypeID
AND tt.title="Gold"
AND tob.bookingReference=b.bookingReference
AND b.customerID=c.customerID;

-- Query 5: names & tickets sold for every event ordered descending
SELECT e.title AS "Event Name", SUM(tob.quantity) AS "Num Tickets Sold"
FROM Events AS e, TicketOnBookings AS tob, Bookings AS b
WHERE tob.bookingReference=b.bookingReference
AND b.eventID=e.eventID
GROUP BY e.title
ORDER BY SUM(tob.quantity) DESC;

-- Query 6: all relevant information from booking when given bookingID
SELECT c.fullName AS Name, b.bookingTime AS "Booking Time", e.title AS "Event Title", case when b.emailTickets then 'Yes' else 'No' end "Email Tickets?", case when NOT b.emailTickets then 'Yes' else 'No' end "Collect Tickets?", tt.title AS "Ticket Type", tob.quantity AS Quantity, b.cost AS "Total Payment £"
FROM Customers AS c, Bookings AS b, Events AS e, TicketTypes AS tt, TicketOnBookings as tob
WHERE c.customerID = 1
AND e.eventID=b.eventID
AND tob.bookingReference=b.bookingReference
AND c.customerID=b.customerID
AND tob.ticketTypeID=tt.ticketTypeID;

-- Query 7: event with maximum income 
DROP VIEW IF EXISTS income_table;
CREATE VIEW income_table AS
SELECT e.title AS title, SUM(b.cost) AS totalIncome
FROM Events AS e, Bookings AS b
WHERE b.eventID = e.eventID
GROUP BY title;
SELECT title AS "Event Title", totalIncome AS "Total Income"
FROM income_table
ORDER BY totalIncome DESC
LIMIT 1;


  