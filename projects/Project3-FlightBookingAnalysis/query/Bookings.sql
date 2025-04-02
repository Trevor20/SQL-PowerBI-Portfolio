USE airport;
SELECT * FROM bookings
LIMIT 10;

ALTER TABLE bookings
ADD COLUMN Booking_id INT PRIMARY KEY AUTO_INCREMENT 
FIRST;

-- Most popular origin
SELECT LEFT(route,3) AS origin, SUM(num_passengers) tot FROM bookings
GROUP BY origin
ORDER BY tot DESC
LIMIT 5;

-- Most popular destination
SELECT RIGHT(route,3) AS destination, SUM(num_passengers) tot FROM bookings
GROUP BY destination
ORDER BY tot DESC
LIMIT 5;

-- most popular route
SELECT CONCAT(LEFT(route,3), '-->', RIGHT(route,3)) AS route, SUM(num_passengers) tot FROM bookings
GROUP BY route
ORDER BY tot DESC
LIMIT 5;

-- Bookings that req baggage
WITH tot_bookings AS(
	SELECT COUNT(booking_id) AS tot FROM bookings
),
extra AS(
		SELECT COUNT(booking_ID) AS ext FROM bookings
        WHERE wants_extra_baggage IS TRUE
)
SELECT ROUND((e.ext/t.tot)*100,2) AS `%req_baggage`
FROM extra e, tot_bookings t;

-- what time of day has most traffic
SELECT flight_hour, SUM(num_passengers) AS traffic FROM bookings
GROUP BY flight_hour
ORDER BY traffic DESC;

-- table with only routes
CREATE TABLE routes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    route CHAR(6) UNIQUE NOT NULL,
    origin CHAR(3),
    destination CHAR(3)
);

INSERT INTO routes(route, origin, destination)
WITH routesss AS(
	SELECT DISTINCT route AS Uni_routes FROM bookings
)
SELECT uni_routes, 
	   LEFT(uni_routes,3), 
       RIGHT(uni_routes, 3)
FROM routesss;

SELECT booking_id, r.route, origin, destination trip_type FROM bookings b
JOIN routes r ON b.route = r.route
LIMIT 10;