use staypoint_hosipitality;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'staypoint_hospitality'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;


select count(*) as total_stays from stays;

show tables;

select sum(total_amount) as total_amount
from bookings 
where hotel_id = "H020";

select max(hotel_id) as highest from bookings;

select count(*),hotel_id from bookings
group by hotel_id;

SELECT HOTEL_ID, COUNT(*) AS TOTAL_BOOKINGS
FROM bookings
GROUP BY HOTEL_ID
ORDER BY TOTAL_BOOKINGS DESC;

select * from bookings;

select booking_channel,count(*) as highest_booking_channel
from bookings
group by booking_channel
order by highest_booking_channel desc;

select sum(total_amount) as generated_amount
from bookings
where booking_channel = "webiste";

SELECT BOOKING_CHANNEL,
       ROUND(AVG(TOTAL_AMOUNT), 2) AS AVG_BOOKING_AMOUNT
FROM bookings
GROUP BY BOOKING_CHANNEL
ORDER BY AVG_BOOKING_AMOUNT DESC;

SELECT BOOKING_CHANNEL,
       SUM(TOTAL_AMOUNT) AS TOTAL_BOOKING_AMOUNT
FROM bookings
GROUP BY BOOKING_CHANNEL
ORDER BY TOTAL_BOOKING_AMOUNT DESC;

select * from bookings;

select room_type_requested,count(*) as total_bookings
from bookings
group by room_type_requested
order by total_bookings DESC;

select room_type_requested,sum(total_amount) as generated_amount
from bookings
where room_type_requested = "standard";

DESC bookings;

SELECT
    YEAR(BOOKING_DATE) AS BOOKING_YEAR,
    MONTH(BOOKING_DATE) AS BOOKING_MONTH,
    COUNT(*) AS TOTAL_BOOKINGS
FROM bookings
GROUP BY
    YEAR(BOOKING_DATE),
    MONTH(BOOKING_DATE)
ORDER BY 
    BOOKING_YEAR,
    BOOKING_MONTH DESC;
    
select * from guests;

select * from bookings;

select guest_id,count(*) as total_bookings
from bookings
group by guest_id
order by total_bookings desc;

select guest_id,sum(total_amount) as whole_amount
from bookings
where guest_id = 'G0350';

select * from bookings;

select guest_id,count(*) as self_booking
from bookings
where booking_channel = "walk-in"
group by guest_id
order by self_booking desc;

SELECT
    g.GUEST_TYPE,
    COUNT(b.BOOKING_ID) AS TOTAL_BOOKINGS
FROM guests g
JOIN bookings b
ON g.GUEST_ID = b.GUEST_ID
GROUP BY g.GUEST_TYPE;

select * from guests;

SELECT
    YEAR(BOOKING_DATE) AS BOOKING_YEAR,
    MONTHNAME(BOOKING_DATE) AS BOOKING_MONTH,
    COUNT(*) AS TOTAL_BOOKINGS
FROM bookings
GROUP BY
    YEAR(BOOKING_DATE),
    MONTH(BOOKING_DATE),
    MONTHNAME(BOOKING_DATE)
ORDER BY
    BOOKING_YEAR,
    MONTH(BOOKING_DATE) desc;
    
use staypoint_hosipitality;

select * from stays;
select * from bookings;

SELECT b.HOTEL_ID,s.STATUS_,COUNT(*) AS TOTAL_STAYS
FROM stays s 
JOIN bookings b ON s.BOOKING_ID = b.BOOKING_ID
WHERE S.STATUS_ = "NO-SHOW"
GROUP BY b.HOTEL_ID,s.STATUS_
ORDER BY b.HOTEL_ID,TOTAL_STAYS DESC;

SELECT
    STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays
GROUP BY STATUS_
ORDER BY TOTAL_STAYS DESC;

SELECT
    b.HOTEL_ID,ROUND(AVG(s.NIGHTS_STAYED), 2) AS AVG_STAY_DURATION
FROM stays s
JOIN bookings b ON s.BOOKING_ID = b.BOOKING_ID
WHERE s.NIGHTS_STAYED IS NOT NULL
GROUP BY b.HOTEL_ID
ORDER BY AVG_STAY_DURATION DESC;

SELECT* FROM STAYS;

SELECT
    b.HOTEL_ID,
    COUNT(*) AS TOTAL_PROBLEM_STAYS
FROM stays s
JOIN bookings b
    ON s.BOOKING_ID = b.BOOKING_ID
WHERE s.STATUS_ IN ('Cancelled', 'No-show')
GROUP BY b.HOTEL_ID
ORDER BY TOTAL_PROBLEM_STAYS DESC; 

SELECT
    YEAR(s.CHECK_IN_DATE) AS STAY_YEAR,
    s.STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays s
GROUP BY
    YEAR(s.CHECK_IN_DATE),
    s.STATUS_
ORDER BY
    STAY_YEAR,
    TOTAL_STAYS DESC;

select * from stays;
select * from staff;

select staff_id,COUNT(stay_id) as handled_stays
from stays
group by staff_id
order by handled_stays desc;


SELECT
    r.ROOM_TYPE,
    COUNT(s.STAY_ID) AS TOTAL_STAYS
FROM rooms r
JOIN stays s
    ON r.ROOM_ID = s.ROOM_ID
GROUP BY r.ROOM_TYPE
ORDER BY TOTAL_STAYS DESC;

SELECT
    b.BOOKING_ID,
    b.GUEST_ID,
    b.HOTEL_ID,
    s.status_
FROM bookings b
JOIN stays s
    ON b.BOOKING_ID = s.BOOKING_ID
WHERE s.STATUS_ IN ('Cancelled', 'No-show');

SELECT
    STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays
GROUP BY STATUS_
ORDER BY TOTAL_STAYS DESC;

select * from hotels;

select * from bookings;

select booking_channel,sum(total_amount) as total_bookings_amount
from bookings
group by booking_channel
order by total_bookings_amount desc;

select guest_id,sum(total_amount) as total_bookings
from bookings
group by guest_id
order by total_bookings desc;

SELECT
    g.GUEST_TYPE,
    COUNT(b.BOOKING_ID) AS TOTAL_BOOKINGS,
    COUNT(DISTINCT g.GUEST_ID) AS TOTAL_GUESTS,
    SUM(b.TOTAL_AMOUNT) AS TOTAL_BOOKING_AMOUNT
FROM guests g
JOIN bookings b
    ON g.GUEST_ID = b.GUEST_ID
GROUP BY g.GUEST_TYPE;

SELECT
    YEAR(BOOKING_DATE) AS BOOKING_YEAR,
    COUNT(DISTINCT GUEST_ID) AS UNIQUE_GUESTS,
    COUNT(*) AS TOTAL_BOOKINGS
FROM bookings
GROUP BY YEAR(BOOKING_DATE)
ORDER BY BOOKING_YEAR;

SELECT
    COUNT(*) AS REPEAT_GUESTS
FROM (
    SELECT GUEST_ID
    FROM bookings
    GROUP BY GUEST_ID
    HAVING COUNT(*) > 1
) AS repeat_customers;

SELECT
    b.HOTEL_ID,
    s.STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays s
JOIN bookings b
    ON s.BOOKING_ID = b.BOOKING_ID
GROUP BY b.HOTEL_ID, s.STATUS_
ORDER BY b.HOTEL_ID, TOTAL_STAYS DESC;


SELECT
    YEAR(CHECK_IN_DATE) AS STAY_YEAR,
    STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays
GROUP BY YEAR(CHECK_IN_DATE), STATUS_
ORDER BY STAY_YEAR, TOTAL_STAYS DESC;

SELECT
    STAFF_ID,
    STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays
GROUP BY STAFF_ID, STATUS_
ORDER BY STAFF_ID, TOTAL_STAYS DESC;
SELECT
    STAFF_ID,
    COUNT(STAY_ID) AS TOTAL_STAYS
FROM stays
GROUP BY STAFF_ID
ORDER BY TOTAL_STAYS DESC;

SELECT
    STAFF_ID,
    ROUND(AVG(NIGHTS_stayed), 2) AS AVG_STAY_DURATION
FROM stays
GROUP BY STAFF_ID
ORDER BY AVG_STAY_DURATION DESC;

SELECT
    r.ROOM_TYPE,
    COUNT(s.STAY_ID) AS TOTAL_STAYS
FROM stays s
JOIN rooms r
    ON s.ROOM_ID = r.ROOM_ID
GROUP BY r.ROOM_TYPE
ORDER BY TOTAL_STAYS DESC;

SELECT
    sTATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays
WHERE STATUS_ IN ('Cancelled', 'No-show')
GROUP BY STATUS_
ORDER BY TOTAL_STAYS DESC;

SELECT
    b.HOTEL_ID,
    s.STATUS_,
    COUNT(*) AS TOTAL_STAYS
FROM stays s
JOIN bookings b
    ON s.BOOKING_ID = b.BOOKING_ID
WHERE s.STATUS_ IN ('Cancelled', 'No-show')
GROUP BY b.HOTEL_ID, s.STATUS_
ORDER BY TOTAL_STAYS DESC;

DESCRIBE stays;

SELECT
    b.HOTEL_ID,
    COUNT(*) AS TOTAL_PROBLEM_STAYS
FROM stays s
JOIN bookings b
    ON s.BOOKING_ID = b.BOOKING_ID
WHERE s.STATUS_ IN ('Cancelled', 'No-show')
GROUP BY b.HOTEL_ID
ORDER BY TOTAL_PROBLEM_STAYS DESC;