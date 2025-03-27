# Coffee Retail Sales Analysis in Saudi Arabia Using SQL and Power BI

## 🚀 Project Overview

This project analyzes coffee retail sales data using SQL for data manipulation and Power BI for interactive visualizations. The goal is to derive insights into sales performance, discount impact and customer behavior.

## 🎯 Objectives 

- Analyze sales trends and identify top-performing products & stores
- Examine the impact of discounts on net sales & profit margins
- Evaluate customer purchasing behavior across different demographics
- Measure store performance based on sales, employees, and management

## 📖 Dataset

The dateset in this project contains sales information of a coffe retail store in Saudi Arabia. The dataset was initially collected from Kraggle, which contained sales data and location of the stores. Additional tables like detailed product, store and customer information was created by me using fictional data and research of approx profit margin of coffee. The added information creates complexity in data analysis. The dataset includes information like transaction date, sales quantity, gross sales, discounts and net sales.

## 📁 Database

To facilitate data management and analysis, a database on MySQL was created to store the dataset. MySQL provdies a robust method to organize and manipulate data. A database schema was created to improve organization and efficiency of queries. The structure allows easy integration with tools like Power BI for visualsation.

## 📂 Database Structure

The final Dataset contains 5 tables

### 1. City_Location                
| Column  | Description    |
|---------|----------------|
| City_Id | Unique City ID |
| City    | City Name      |
| Lat     | Latitude       |
| Long    | Longitude      | 

### 2. Customer_Details
| Column | Description        |
|--------|--------------------|
| Id     | Unique Customer ID |
| Name   | Full Name          |
| Age    | Customer Age       | 

### 3. Product_Details
| Column      | Description       |
|-------------|-------------------|
| Prod_Id     | Unique Product ID |
| Product     | Name of the coffee|
| Unit_Cost   | Cost per unit     |
| Unit_Price  | Price per unit    | 

### 4. Sales_Data
| Column | Description           |
|--------|-----------------------|
| Shop_Id| Unique Shop ID        |
| City   | Shop Location         |
| Name   | Name of the manager   |
| Gender | Gender of the manager |
| Age    | Age of the manager    |

### 5. Sales_Data
| Column        | Description                            |
|---------------|----------------------------------------|
| Sales_Id      | Unique Transaction Id                  |
| Sell_Date     | Date the sale occured                  |
| Customer      | Customer Id                            |
| Store         | Store Id                               |
| Product       | Product Id                             |
| Quantity      | Amount sold                            |
| Sales_Amt     | Gross Sales                            |
| Used_Discount | Whether Customer used discount(Yes/No) |
| Discount_Amt  | Discount amount                        |
| Final_Sales   | Net Sales                              |

## 🔍 Key Business Questions Answered

1️. What are the top 5 best-selling products?
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

### 1. Extract, Transform, Load using MySQL
1. fijwf
2. fwfw

### 2. Data Visualatization Using Power BI
1. iji
2. dddq

## 🏆 Final Insights
- u
- uh
- ddd


