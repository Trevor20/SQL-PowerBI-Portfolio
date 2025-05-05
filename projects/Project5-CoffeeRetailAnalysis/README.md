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

## 🧰 Tools Used

- MySQL - For data cleaning, transformation, and star schema modelling.
- Power BI - For building interactive dashboards and visuals.
- DAX - For calculated columns, measures, and KPIs
- Data Modelling - Establishing star schema relationship between tables

## 📁 Database

To facilitate data management and analysis, a database on MySQL was created to store the dataset. A database star schema was created to improve organization and efficiency of queries.

## 📂 Database Structure

The MySQL database uses a star schema with five related tables:

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
2. How do sales trends vary monthly and daily?
3. Which stores generate the highest revenue?
4. What is the impact of discounts on net sales?
5. How does customer gender influence discount usage?
6. Which managers outperform others in net sales?
7. What is the customer age distribution of sales?
8. How do gross profit and discounts correlate?
9. Which cities contribute the most to sales volume?
10. How does product profitability vary across locations?

## ➡️ Project Approach

### 1. Extract, Transform, Load, and Analysis using MySQL
1. Created a SQL database and loaded the CSV datasets using Table Data Import Wizard. 
2. Cleaned data by addressing incorrect date formats, replaced redundant text-based values with Unique ids to initiate faster querying through relational joins.
3. Deleted unnecessary columns to increase efficiency of data structure.
4. Build a star schema with primary and foreign key relationships.
5. Conducted initial data analysis using SQL queries, including CTEs, Joins and window functions.

### 2. Data Visualatization Using Power BI
Connected Power BI to MySQL Database via Direct Query and built the following visuals
1. Overview - Summary of relevant KPIs like total sales, best product and best store.
2. Product analysis - To understand demand, amount sold and gross profils accross different coffee brands.
3. Time-series analysis - Visuals that show monthly and weekday transaction patterns.
4. Store analysis - To compared managers performance across stores.
5. Customer analysis - To indentify top customers and gender-wise discount analysis.

## 🏆 Final Insights
- ☕ Colombian coffee is the best-selling product, and Hail is the highest performing city.
- 📆 Sales spike on Monday and Friday, likely due to start/end of workweek.
- 🏪 All stores perform similarly in gross profit, indicating consistent operations.
- 📈 Discounts have a positive correlation with net sales, especially among female customers.
- 🕵️‍♀️ Top 5 customers alone contribute significantly to total revenue, highlighting potential for loyalty programs.
