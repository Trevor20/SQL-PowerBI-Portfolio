-- Creating new database absenteeism
SHOW DATABASES;
DROP DATABASE IF EXISTS absenteeism;
CREATE DATABASE absenteeism;
USE absenteeism;
-- Added tables using Table Data Import Wizard

-- Testing if all tables are added correctly
SELECT * FROM absent_data;
SELECT * FROM compensation;
SELECT * FROM reasons;

-- Create a join table
SELECT * FROM absent_data a
LEFT JOIN compensation c
ON a.id = c.id
LEFT JOIN reasons r
ON a.`reason for absence` = r.number;

-- Find the healthiest employees for the bonus
SELECT * FROM absent_data
WHERE `Social drinker` = 0 
  AND `social smoker` = 0 
  AND `body mass index` BETWEEN 19 AND 25
  AND `absenteeism time in hours` < (SELECT AVG(`absenteeism time in hours`) FROM absent_data)
ORDER BY `body mass index` DESC, `absenteeism time in hours`
LIMIT 10;

-- Compensation rate increase for non-smokers/budget 983,221
SELECT (983221/COUNT(*)) as `comp/year` FROM absent_data
WHERE `social smoker` = 0;

-- Creating a view of relevant data for analysis
CREATE OR REPLACE VIEW Analysis_Data AS
SELECT a.id,
	   r.reason,
       `body mass index`,
       CASE
			WHEN `body mass index` < 18.5 THEN "Underweight"
            WHEN `body mass index` BETWEEN 18.5 AND 25 THEN "Healthy"
            WHEN `body mass index` BETWEEN 25 AND 30 THEN "Overweight"
            WHEN `body mass index` > 30 THEN "Obese"
            ELSE "Unknown"
	   END AS BMI_Category,
       CASE 
			WHEN `month of absence` IN (12,1,2) THEN "Winter"
            WHEN `month of absence` IN (3,4,5) THEN "Spring"
            WHEN `month of absence` IN (6,7,8) THEN "Summer"
            WHEN `month of absence` IN (9,10,11) THEN "Fall"
            ELSE "Unknown"
	   END AS Season_Name,
       `month of absence`,
       `day of the week`,
       `transportation expense`,
       `distance from residence to work`,
       education,
       son,
       `social drinker`,
       `social smoker`,
       pet,
       `disciplinary failure`,
       age,
       `absenteeism time in hours`,
       `comp/hr`
FROM absent_data a
LEFT JOIN compensation c
ON a.id = c.id
LEFT JOIN reasons r
ON a.`reason for absence` = r.number;

-- Testing View
SELECT * FROM analysis_data;