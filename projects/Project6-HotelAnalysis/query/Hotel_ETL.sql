-- Checking current databases and creating new one
SHOW DATABASES;
DROP DATABASE IF EXISTS hotels;
CREATE DATABASE hotels;
USE hotels;
SELECT DATABASE();

-- Creating country code dimension
DROP TABLE IF EXISTS dim_country_codes;
CREATE TABLE dim_country_codes(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Abbrev CHAR(3),
    Country VARCHAR(100)
);

-- Creating agent table
DROP TABLE IF EXISTS dim_agent;
CREATE TABLE dim_agent(
	agent_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(155),
    last_name VARCHAR(155),
    gender VARCHAR(10),
    client_name VARCHAR(255),
    type VARCHAR(100),
    location CHAR(3),
    UNIQUE(first_name, last_name)
);

-- Creating customer details
DROP TABLE IF EXISTS dim_customers;
CREATE TABLE dim_customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    gender VARCHAR(10),
	age TINYINT UNSIGNED,
    country CHAR(3)
);

-- Creating hotel details
DROP TABLE IF EXISTS dim_hotel;
CREATE TABLE dim_hotel(
	id INT AUTO_INCREMENT PRIMARY KEY,
    hotel VARCHAR(255) NOT NULL,
    address VARCHAR(1000),
    loc VARCHAR(255),
    stars DECIMAL(3,2),
    rooms INT,
    brand VARCHAR(100),
    type VARCHAR(100)
);

-- Creating meal details
DROP TABLE IF EXISTS dim_meals;
CREATE TABLE dim_meals(
	id INT AUTO_INCREMENT PRIMARY KEY,
    code CHAR(2),
    meal VARCHAR(100),
    description VARCHAR(255),
    avg_rate DECIMAL(6,2),
    type VARCHAR(100)
);

-- Creating room details
DROP TABLE IF EXISTS dim_rooms;
CREATE TABLE dim_rooms(
	id INT AUTO_INCREMENT PRIMARY KEY,
    code CHAR(1),
    category VARCHAR(100),
    avg_area VARCHAR(100),
    bedrooms VARCHAR(50),
    bed_type VARCHAR(100),
    view VARCHAR(100),
    wifi VARCHAR(3),
    balcony VARCHAR(10),
    bathroom VARCHAR(10),
    lounge VARCHAR(100)
);

-- Creating table bookings
DROP TABLE IF EXISTS fact_bookings;
CREATE TABLE fact_bookings(
	sales_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    hotel VARCHAR(255),
    hotel_type VARCHAR(100),
    is_cancelled BOOLEAN,
    lead_time INT,
    arrival_year INT,
    arrival_month VARCHAR(100),
    arrival_week_no TINYINT,
    arrival_day_of_month TINYINT,
    nightStays_weekend INT,
    nightStays_weekday INT,
    adults INT,
    children INT DEFAULT 2,
    babies TINYINT,
    meal VARCHAR(10),
    country VARCHAR(3),
    market_segment VARCHAR(255),
    distribution_channel VARCHAR(100),
    is_repeated_guest BOOLEAN,
    previous_cancellations SMALLINT,
    previous_bookings_not_cancelled SMALLINT,
    reserved_room_type VARCHAR(1),
    assigned_room_type VARCHAR(1),
    booking_changes INT,
    deposit_type VARCHAR(100),
    agent_id VARCHAR(100) NOT NULL DEFAULT 0,
    company VARCHAR(255) NOT NULL DEFAULT 'Direct Guest',
    days_in_waiting_list INT,
    customer_type VARCHAR(100),
    `adr(room)` DECIMAL(6,2),
    required_car_parking_spaces TINYINT,
    total_special_requests TINYINT,
    reservation_status VARCHAR(100),
    reservation_status_date VARCHAR(255)
);
-- Extract data using Table Data Import Wizard
SELECT COUNT(*) from dim_agent;
SELECT COUNT(*) from dim_country_codes;
SELECT COUNT(*) from dim_customers;
SELECT COUNT(*) from dim_hotel;
SELECT COUNT(*) from dim_meals;
SELECT COUNT(*) from dim_rooms;
SELECT COUNT(*) from fact_bookings;

-- Remove duplicates from country_codes
DELETE FROM dim_country_codes
WHERE id NOT IN(
				SELECT id FROM (
								SELECT MIN(id) AS id FROM dim_country_codes
								GROUP BY abbrev
                                ) AS Safe_Query
                );

SELECT * FROM dim_country_codes;

-- convert loc in agent table to loc id
UPDATE dim_agent da
LEFT JOIN dim_country_codes dcc ON 
da.location = dcc.abbrev
SET da.location = dcc.id;

-- Convert country in customers table to location id
UPDATE dim_customers dc
LEFT JOIN dim_country_codes dcc
ON dc.country = dcc.abbrev
SET dc.country = dcc.id;

SELECT * FROM dim_customers;

-- Delete address in dim_hotel
ALTER TABLE dim_hotel
DROP COLUMN address;

-- Substitute price range with average price in dim_rooms
ALTER TABLE dim_rooms
ADD COLUMN Avg_area_final DECIMAL(5,2)
AFTER avg_area;

UPDATE Dim_rooms
SET avg_area_final = (
						CAST(substring_index(avg_area, '–',1) AS UNSIGNED) +
                        CAST(substring_index(avg_area, '–',-1) AS UNSIGNED)
					)/2
;

ALTER TABLE dim_rooms
DROP COLUMN avg_area;

ALTER TABLE dim_rooms
RENAME COLUMN avg_area_final TO avg_area;

SELECT * FROM dim_rooms;

-- Convert hotel and hotel type into hotel_id
ALTER TABLE fact_bookings ADD COLUMN hotel_id INT;
ALTER TABLE fact_bookings MODIFY COLUMN hotel_id INT AFTER hotel_type;
UPDATE fact_bookings fb
LEFT JOIN dim_hotel dh ON
fb.hotel = dh.hotel AND fb.hotel_type = dh.type
SET hotel_id = dh.id;

-- Convert arrival year, month, week number, day of month into date format
DELIMITER $$
CREATE FUNCTION get_month_number(month_name VARCHAR(50))
RETURNS INT
DETERMINISTIC 
BEGIN
	DECLARE month_no INT;
    
    SET month_no = CASE LOWER(month_name)
			WHEN 'January' THEN 1
            WHEN 'February' THEN 2
            WHEN 'March' THEN 3
            WHEN 'April' THEN 4
            WHEN 'May' THEN 5
            WHEN 'June' THEN 6
            WHEN 'July' THEN 7
            WHEN 'August' THEN 8
            WHEN 'September' THEN 9
            WHEN 'October' THEN 10
            WHEN 'November' THEN 11
            WHEN 'December' THEN 12
            ELSE NULL
		END;
		
        RETURN month_no;
END$$
DELIMITER ;

ALTER TABLE fact_bookings 
ADD COLUMN arrival_date DATE
AFTER lead_time;

UPDATE fact_bookings
SET arrival_date = CONCAT_WS('-', arrival_year, get_month_number(arrival_month), arrival_day_of_month);

ALTER TABLE fact_bookings
MODIFY COLUMN arrival_date DATE;

-- Convert month into season
ALTER TABLE fact_bookings
ADD COLUMN season VARCHAR(10)
AFTER lead_time;

UPDATE fact_bookings
SET season = CASE 
				WHEN get_month_number(arrival_month) IN (12,1,2) then 'Winter'
				WHEN get_month_number(arrival_month) IN (3,4,5) THEN 'Spring'
				WHEN get_month_number(arrival_month) IN (6,7,8) THEN 'Summer'
				WHEN get_month_number(arrival_month) IN (9,10,11) THEN 'Autumn'
				ELSE NULL
			END;

-- Convert meal into meal_id
ALTER TABLE fact_bookings 
ADD COLUMN meal_id INT
AFTER meal;

UPDATE fact_bookings fb
LEFT JOIN dim_meals dm ON
DM.code = fb.meal AND dm.type = fb.hotel_type
SET meal_id = dm.id;
-- checking for significance in undefined meals according to year
select arrival_year, sum(`adr(room)`) from fact_bookings
where meal_id is null
group by arrival_year;

select arrival_year, sum(`adr(room)`) from fact_bookings
group by arrival_year;

select hotel, count(*) as missing_meals, sum(`adr(room)`) as revenue from fact_bookings
where meal_id is null
group by hotel
order by revenue;
-- preserving undefined meals just in case
CREATE TABLE archived_undefined_meals AS
SELECT * FROM fact_bookings
WHERE meal_id IS NULL;

SELECT * from ARCHIVED_undefined_meals;
-- deleting undefined meals since they are insignificant
DELETE FROM fact_bookings
WHERE meal_id IS NULL;

-- Convert reserved room type into room_id
ALTER TABLE fact_bookings
ADD COLUMN reserved_room_id INT
AFTER reserved_room_type;

UPDATE fact_bookings fb
LEFT JOIN dim_rooms dr ON fb.reserved_room_type = dr.code
SET reserved_room_id = id;

-- Convert assigned room type into room_id
ALTER TABLE fact_bookings
ADD COLUMN assigned_room_id INT
AFTER assigned_room_type;

UPDATE fact_bookings fb
LEFT JOIN dim_rooms dr ON fb.assigned_room_type = dr.code
SET assigned_room_id = id;

-- put null values of agent_id and company into 31
UPDATE fact_bookings
SET agent_id = 31,
	company = 0
WHERE agent_id = '';

select agent_id from fact_bookings
where agent_id regexp '[^0-9]';

ALTER TABLE fact_bookings
MODIFY COLUMN agent_id INT;

-- Convert reservation date to date format
ALTER TABLE fact_bookings
ADD COLUMN reservation_status_date_T DATE;

UPDATE fact_bookings
SET reservation_status_date_T = STR_TO_DATE(reservation_status_date, '%d-%m-%Y');

-- Creating a backup before deleting columns
CREATE TABLE archived_bookings AS
SELECT * FROM fact_bookings;

-- Delete arrival dates, Company, distribution_channel, hotel_type, arrival stuff, country_id
ALTER TABLE fact_bookings
DROP COLUMN hotel,
DROP COLUMN hotel_type,
DROP COLUMN arrival_year,
DROP COLUMN arrival_month,
DROP COLUMN arrival_week_no,
DROP COLUMN arrival_day_of_month,
DROP COLUMN meal,
DROP COLUMN country,
DROP COLUMN reserved_room_type,
DROP COLUMN assigned_room_type,
DROP COLUMN company,
DROP COLUMN reservation_status_date;

ALTER TABLE fact_bookings
RENAME COLUMN reservation_status_date_T TO reservation_status_date;

-- delect adr < 0
DELETE FROM fact_bookings
WHERE `adr(room)` < 0;

-- convert country var to int
ALTER TABLE dim_customers
MODIFY country INT;

-- Creating foreign keys
desc fact_bookings;
desc dim_agent;
desc dim_country_codes;
desc dim_customers;
desc dim_hotel;
desc dim_meals;
desc dim_rooms;

ALTER TABLE dim_agent
MODIFY COLUMN location INT;

ALTER TABLE fact_bookings
ADD CONSTRAINT FK_agents 
FOREIGN KEY(agent_id) REFERENCES dim_agent(agent_id);

ALTER TABLE fact_bookings
ADD CONSTRAINT FK_customers
FOREIGN KEY(customer_id) REFERENCES dim_customers(id);

ALTER TABLE fact_bookings
ADD CONSTRAINT FK_hotel
FOREIGN KEY(hotel_id) REFERENCES dim_hotel(id);

ALTER TABLE fact_bookings
ADD CONSTRAINT FK_meal
FOREIGN KEY(meal_id) REFERENCES dim_meals(id);

ALTER TABLE fact_bookings
ADD CONSTRAINT FK_reserved_room
FOREIGN KEY(reserved_room_id) REFERENCES dim_rooms(id);

ALTER TABLE fact_bookings
ADD CONSTRAINT fk_assigned_room
FOREIGN KEY(assigned_room_id) REFERENCES dim_rooms(id);

ALTER TABLE dim_agent
ADD CONSTRAINT FK_location
FOREIGN KEY(location) REFERENCES dim_country_codes(id);

ALTER TABLE dim_customers
ADD CONSTRAINT FK_Clocation
FOREIGN KEY(country) REFERENCES dim_country_codes(id);

-- Creating indexes for increasing performance
CREATE INDEX idx_reservation_status ON fact_bookings(reservation_status);

-- Adding rooms column
ALTER TABLE fact_bookings 
ADD COLUMN rooms INT;

UPDATE fact_bookings
SET rooms = CEIL((adults + children)/2);

-- Adding daily revenue(room) column
ALTER TABLE fact_bookings
ADD COLUMN adr_booking decimal(6,2) AFTER `adr(room)`;

UPDATE fact_bookings
SET adr_booking = `adr(room)`*rooms;

-- Adding children/baby rate
ALTER TABLE dim_meals
ADD COLUMN avg_rate_child DECIMAL(6,2) AFTER avg_rate,
ADD COLUMN avg_rate_baby DECIMAL(6,2) AFTER avg_rate_child;

UPDATE dim_meals
SET avg_rate_child = avg_rate*0.5;

UPDATE dim_meals
SET avg_rate_baby = avg_rate*0;

ALTER TABLE dim_meals
RENAME COLUMN avg_rate TO avg_rate_adult;

-- Completed
USE hotels;