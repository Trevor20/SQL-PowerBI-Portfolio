CREATE DATABASE real_estate;
USE real_estate;

SELECT COUNT(*) FROM apt_dubai;
DROP TABLE apt_dubai;


-- address to city and district
SELECT displayADDRESS,
	   SUBSTRING_INDEX(displayaddress, ', ', -1) AS city,
       SUBSTRING_INDEX(SUBSTRING_INDEX(displayaddress, ', ', -2), ', ', 1) AS district
FROM apt_dubai;

-- changing timestamp
SELECT apt_id, 
	   addedon,
       REPLACE(REPLACE(addedOn, 'T', ' '),'Z', '') AS time
FROM apt_dubai;

-- updating timestampt
UPDATE apt_dubai
SET addedOn = REPLACE(REPLACE(addedOn, 'T', ' '),'Z', '');

-- Changing data type in AddedOn
ALTER TABLE apt_dubai
MODIFY addedOn DATETIME;

-- creating a new table with locations
CREATE TABLE location(
	full_add VARCHAR(255) PRIMARY KEY,
    City VARCHAR(100) NOT NULL DEFAULT 'Dubai',
    District VARCHAR(250) NOT NULL
);

-- inserting values into location
INSERT INTO location(full_add, City, District)
WITH full_address AS(
	SELECT DISTINCT displayADDRESS FROM apt_dubai
)
SELECT displayADDRESS,
	   SUBSTRING_INDEX(displayaddress, ', ', -1) AS city,
       SUBSTRING_INDEX(SUBSTRING_INDEX(displayaddress, ', ', -2), ', ', 1) AS district
FROM full_address;

-- add index(id) to location ans set it as primary key
ALTER TABLE location
DROP PRIMARY KEY;

ALTER TABLE location
ADD COLUMN loc_id INT AUTO_INCREMENT PRIMARY KEY;

-- replace displayAddress with displayId
UPDATE apt_dubai a
JOIN location l ON a.displayADDRESS = l.full_add
SET a.displayaddress = l.loc_id;

-- make displayId as foreign key
ALTER TABLE apt_dubai
MODIFY displayAddress INT;

ALTER TABLE apt_dubai
ADD CONSTRAINT Location 
FOREIGN KEY(displayADDRESS)
REFERENCES location(loc_id);

-- backup
CREATE TABLE apt_dubai_backup AS
SELECT * FROM apt_dubai;

-- test
SELECT apt_id, displayaddress, loc_id, full_add, district FROM apt_dubai a
JOIN location l ON a.displayaddress = l.loc_id
LIMIT 200;