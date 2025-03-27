USE Coffee_Sales;

-- Total sales and total final sales across all stores
SELECT Store,
	   SUM(Sales_Amt) AS `Sales Before Discount`,
	   SUM(Final_Sales) AS `Sales After Discount`
FROM Sales_Data
GROUP BY Store;

-- Which Product generate the highest revenue
SELECT Prod_Id, pd.Product, SUM(Final_Sales) AS Tot_Sales
FROM Sales_Data sd
JOIN Product_Details pd on sd.product = pd.Prod_id
GROUP BY sd.Product
ORDER BY Tot_Sales DESC;

-- Which Cities have the highest sales
SELECT Cl.city, SUM(Final_Sales) AS Tot_Sales 
FROM Sales_Data sd 
JOIN Store_Details SrD ON sd.store = Srd.Shop_ID
JOIN City_Location Cl ON SrD.City = Cl.City_Id
GROUP BY Cl.city
ORDER BY Tot_Sales DESC;

-- How do Sales trends vary monthly
SELECT MONTHNAME(Sell_Date) AS `month`, SUM(Final_Sales)
FROM Sales_data
GROUP BY MONTH(Sell_Date), MONTHNAME(Sell_Date)
ORDER BY MONTH(Sell_Date);

-- How do Sales trends vary during the week
SELECT DAYNAME(Sell_Date) AS Week_day, SUM(Final_Sales)
FROM Sales_data
GROUP BY WEEKDAY(Sell_Date), Week_day
ORDER BY WEEKDAY(Sell_Date);

-- Which customers contribute the most to sales
SELECT Customer, Full_name, SUM(Final_Sales) AS tot_sales 
FROM Sales_data sd
JOIN Customer_Details cd ON sd.customer = cd.id
GROUP BY Customer
ORDER BY tot_sales DESC
LIMIT 10;

-- Which % of sales transaction involve a discount
WITH transactions AS(
SELECT COUNT(*) AS tot_transactions,
	   SUM(Used_discount) AS Disc_Transactions
FROM Sales_data)
SELECT ROUND(Disc_Transactions/tot_transactions*100,2)
FROM transactions;

-- Whats the profitability of each product category
SELECT pd.product, 
	   ROUND((SUM(final_sales - quantity*unit_cost))/SUM(Final_sales)*100,0) AS `gross_profit(%)`
FROM Product_Details pd
JOIN Sales_data sd ON sd.product = pd.prod_id
GROUP BY pd.product
ORDER BY `gross_profit(%)` DESC;

-- which store managers are leading the most profitable stores
SELECT Manager, 
	   SUM(final_sales - (quantity*unit_cost)) AS gross_profit
FROM sales_data sl
JOIN store_details sd ON sl.store = sd.shop_id 
JOIN product_details pd ON pd.prod_id = sl.product
GROUP BY manager
ORDER BY gross_profit DESC
LIMIT 5;

-- Average sales according to gender
SELECT Gender, 
	   ROUND(SUM(final_sales)/(SELECT SUM(final_sales) FROM sales_data)*100,0) AS `tot_sales%` 
FROM sales_data sl
JOIN store_details sd on sl.store = sd.shop_id
GROUP BY gender;

-- Which Store locations should receive more inventory based on total quantity
SELECT loc.city, SUM(Quantity) AS tot_demand
FROM Sales_data sl 
JOIN Store_Details sd ON sl.store = sd.shop_id
JOIN City_location loc ON sd.city = loc.city_id
GROUP BY loc.city
ORDER BY tot_demand DESC
LIMIT 5;

-- which location should receive the most quantity of a specific product 
-- PROd 1 - store 8, 2 - 1, 3-9, 4-6, 5-4
SELECT product, store, SUM(quantity) AS demand from sales_data
GROUP BY product, store
HAVING product = 1
ORDER BY product, demand DESC
LIMIT 1;

