DROP DATABASE IF EXISTS Coffee_Sales;
CREATE DATABASE Coffee_Sales;
USE Coffee_Sales;

-- Creating Table
DROP TABLE IF EXISTS Product_Details;
CREATE TABLE Product_Details(
	Prod_Id INT PRIMARY KEY,
    Product VARCHAR(100),
    Unit_Price INT,
    Unit_Cost INT
);

DROP TABLE IF EXISTS Store_Details;
CREATE TABLE Store_Details(
	Shop_Id INT PRIMARY KEY,
    City VARCHAR(50),
    Manager VARCHAR(255),
    Gender CHAR(1),
    Age INT
);

DROP TABLE IF EXISTS Customer_Details;
CREATE TABLE Customer_Details(
	Id INT PRIMARY KEY,
    Full_name VARCHAR(255),
    Age INT,
    Gender CHAR(1)
);

DROP TABLE IF EXISTS City_Location;
CREATE TABLE City_Location(
	City_Id INT PRIMARY KEY AUTO_INCREMENT,
    City VARCHAR(100),
    Latitude DECIMAL(6,4),
    Longitude DECIMAL(6,4)
);

DROP TABLE IF EXISTS Sales_Data;
CREATE TABLE Sales_Data(
	Sales_Id INT AUTO_INCREMENT PRIMARY KEY,
    Sell_Date VARCHAR(100), -- Since Date is not formatted according to MySQL at Source
	Customer INT,
    Location VARCHAR(100),
    Category VARCHAR(100),
    Product VARCHAR(255),
    Unit_Price INT,
    Quantity INT,
    Sales_Amt INT,
    Used_Discount VARCHAR(10),
    Discount_Amt INT,
    Final_Sales INT,
    FOREIGN KEY(Customer) REFERENCES Customer_Details(Id)
);

-- Imported Data using Table Data Import Wizard

-- Checking if data is imported correctly
SELECT * FROM City_Location;
SELECT * FROM Customer_Details;
SELECT * FROM Product_Details;
SELECT * FROM Sales_Data;
SELECT * FROM Store_Details;

-- Pre-Processing Data
-- Subsituting City(Sales_Data) to Store_details(Id)
UPDATE Sales_Data Sl
JOIN Store_Details Sd ON Sl.Location = sd.city
SET Sl.Location = sd.Shop_Id;
-- Changing Location to Store and changing datatype to INT
ALTER TABLE Sales_Data
CHANGE COLUMN Location Store INT;

-- Substituting City(Store_Details) to City_Id
UPDATE Store_Details S
JOIN City_Location C ON S.city =  C.City
SET S.City = C.City_Id;
-- Changing City to INT From VARCHAR
ALTER TABLE Store_Details
MODIFY City INT;
-- Connecting Store_Details to City_Location through Primary/Foreign Key
ALTER TABLE Store_Details
ADD CONSTRAINT City_Location
FOREIGN KEY(City)
REFERENCES City_Location(City_Id);

-- Testing if processing is correct
SELECT Sales_id, Customer, Store, Shop_id,
	   sd.City, Manager, City_id, 
       cl.City, Latitude, Longitude
FROM sales_data sl JOIN store_details sd ON sl.store = sd.shop_id
JOIN city_location cl ON sd.city = cl.city_id;

-- Connecting id(product) to product(Sales data)
UPDATE Sales_Data Sd
JOIN product_details pd ON sd.product = pd.product
SET sd.product = pd.prod_id;
-- changing product to int
ALTER TABLE Sales_data
MODIFY product INT;

SELECT DISTINCT product, unit_price from sales_data ;
SELECT * FROM product_details;
select category from sales_data;

-- Removing redundant columns 
ALTER TABLE Sales_data
DROP COLUMN Category,
DROP COLUMN Unit_Price;


-- Change False/True to 0/1
UPDATE Sales_Data
SET Used_Discount = CASE
	WHEN Used_Discount = 'False' THEN 0
    WHEN Used_Discount = 'True' THEN 1
END;
ALTER TABLE Sales_Data
MODIFY Used_Discount INT;

-- rectify sell_date format and change datatype
UPDATE Sales_data
SET Sell_Date = CASE
	WHEN sell_date LIKE '%/%/%' THEN str_to_date(sell_date, '%m/%d/%Y')
	WHEN sell_date LIKE '%-%-%' THEN str_to_date(sell_date, '%m-%d-%Y')
END;

ALTER TABLE Sales_data
MODIFY Sell_Date DATE;

-- adding foreign keys 
ALTER TABLE Sales_data
ADD CONSTRAINT Store_Details
FOREIGN KEY(Store)
REFERENCES Store_Details(Shop_Id);

ALTER TABLE Sales_data
ADD CONSTRAINT Product_Details
FOREIGN KEY(Product)
REFERENCES Product_Details(Prod_Id);
DESC sales_data;


-- checking primaryKey-ForeignKey Pairs
SELECT 
    fk.TABLE_NAME AS Foreign_Table, 
    fk.COLUMN_NAME AS Foreign_Column, 
    fk.CONSTRAINT_NAME AS FK_Name, 
    pk.TABLE_NAME AS Primary_Table, 
    pk.COLUMN_NAME AS Primary_Column
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE fk
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE pk 
    ON fk.REFERENCED_TABLE_NAME = pk.TABLE_NAME 
    AND fk.REFERENCED_COLUMN_NAME = pk.COLUMN_NAME
WHERE fk.REFERENCED_TABLE_NAME IS NOT NULL
AND fk.TABLE_SCHEMA = DATABASE();

-- Adding Profit/Unit in Product_Details
ALTER TABLE Product_Details
ADD COLUMN Unit_Profit INT AS (Unit_Price - Unit_Cost) 
AFTER Unit_Cost;
