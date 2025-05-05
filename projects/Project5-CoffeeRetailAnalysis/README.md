# Coffee Retail Sales Analysis in Saudi Arabia using SQL and Power BI

## 🚀 Project Overview

This project analyzes coffee retail sales data using SQL for data manipulation and Power BI for interactive visualizations. The goal is to derive insights into sales performance, discount impact and customer behavior to support business decisions.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project5-CoffeeRetailAnalysis/reports)

## 🧠 Business Problem

A coffee retailer chain in Saudi Arabia operates five stores and offers five different coffee products. They want to improve sales, profitability and customer engagement. Despite steady sales, management is uncertain about:
- Which stores and products contribute most to profitability.
- How discounts affect overall revenue.
- When during the day and the week get the most demand.
The goal is to optimize pricing, promotions, and inventory strategies through data-driven insights.

## 🎯 Objectives 

- Identify top-performing products, managers & stores.
- Analyse sales trends over time.
- Examine the impact of discounts on net sales & profit margins.
- Evaluate highest spending customers for targeted marketing campaigns.
- Measure store performance based on sales, employees, and management.

## 📖 Dataset

The dataset simulates coffee retail sales in Saudi Arabia, originally sourced from Kaggle, with additional fictional customer, store, and product tables created manually to enhance analysis. Key fields include:
- Transaction data
- Quanntity sold
- Gross sales, discount and net sales
- Customer demographics
- Product details
The dateset in this project contains sales information of a coffe retail store in Saudi Arabia. The dataset was initially collected from Kraggle, which contained sales data and location of the stores. Additional tables like detailed product, store and customer information was created by me using fictional data and research of approx profit margin of coffee. The added information creates complexity in data analysis. The dataset includes information like transaction date, sales quantity, gross sales, discounts and net sales.

## 🧰 Tools Used

- MySQL - For data cleaning, transformation, and modelling.
- Power BI - For building interactive dashboards and visuals.
- DAX - For calculated columns, measures, and KPIs
- Data Modelling - For establishing star schema relationship between tables

## 📁 Database

To facilitate data management and analysis, a database on MySQL was created to store the dataset. A database star schema was created to improve organization and efficiency of queries.

## 📂 Database Structure

The database contains 5 tables

### 1. City_Geoocation                
| Column  | Description    |
|---------|----------------|
| City    | City Name      |
| Lat     | Latitude       |
| Long    | Longitude      | 

### 2. Customer_Details
| Column | Description          |
|--------|----------------------|
| Id     | Unique Customer ID   |
| Name   | Full Name            |
| Age    | Age                  |
| Gender | Gender (Male/Female) |

### 3. Product_Details
| Column      | Description       |
|-------------|-------------------|
| Prod_Id     | Unique Product ID |
| Product     | Name of the coffee|
| Unit_Cost   | Cost per unit     |
| Unit_Price  | Price per unit    | 

### 4. Store_Details
| Column  | Description              |
|---------|--------------------------|
| Shop_Id | Unique Shop ID           |
| City    | Shop Location            |
| Manager | Full Name of the manager |
| Gender  | Gender of the manager    |
| Age     | Age of the manager       |

### 5. Coffee_Purchases
| Column        | Description                                        |
|---------------|----------------------------------------------------|
| Date          | Date the sale occured                              | 
| Customer_Id   | Customer Id                                        |
| City          | Location of the store                              |
| Category      | Type of coffee - Coffee beans is the only category |
| Product       | Name of the coffee                                 |
| Unit Price    | Price per cup of coffee                            |
| Quantity      | Amount sold                                        |
| Sales Amount  | Gross Sales                                        |
| Used_Discount | Whether Customer used discount(False/True)         |
| Discount_Amt  | Discount amount                                    |
| Final_Sales   | Net Sales                                          |

## 🔍 Key Business Questions Answered

1. What are the top 5 best-selling products?
2. How do monthly sales trends change over time?
3. Which stores generate the highest revenue?
4. What is the impact of discounts on net sales?
5. How does customer gender influence discount usage?
6. Which stores have the most profitable managers?
7. What is the customer age distribution of sales?
8. How do gross profit and discounts correlate?
9. Which cities contribute the most to sales volume?
10. How does product profitability vary across locations?

## ➡️ Project Approach

### 1. Extract, Transform, Load, and Analysis using MySQL
1. Created a SQL database and tables, and loaded data from CSV files into the database using Table Data Import Wizard. 
2. Cleaned data by addressing incorrect date formats, replaced redundant text-based values with Unique ids to initiate faster querying through relational joins.
3. Deleted unnecessary columns to increase efficiency of data structure.
4. Added primary and foreign keys to build a star-schema like relational design
5. Conducted initial data analysis using SQL queries, including CTEs, Joins and window functions.

### 2. Data Visualatization Using Power BI
Connected Power BI to MySQL Database through Direct Query and build the following visuals
1. Overview - Summary of relevant KPIs like total sales, best product and best store
2. Product analysis - Understand the distribution of demand, amount sold and gross profils accross different coffee brands
3. Time-series analysis - graphs that show the transactions over time, allows the viewer to see peak hours/days
4. Store analysis - To compared managers performance across stores
5. Customer analysis - To understand most popular products and where gender had an impact on discounts and sales 

## 🏆 Final Insights
- Monday and Friday has the most rush for coffee, probably due to the fact that those are the start and end of the work week
- There doesnt seem to be a significant difference in net sales and profit across all stores, all stores have gross profit close to the overall average 
- Colombian coffee is the most popular while Hail is the city with most transactions
- Net sales increases as total discount increases. This indicates that providing discounts at the right time is beneficial to the overall sales
