# Hotel Booking Analysis in Dubai Hospitality Market using SQL and Power BI

## 🚀 Project Overview

This project analyzes hotel bookings of the top 20 hotels in Dubai. The goal is to derive decision-oriented insights into customer trends, booking patterns and competitive hotel performance. The analysis combines SQL for data transformation and business logic with Power BI for interactive visual analytics.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project5-CoffeeRetailAnalysis/reports)

## 🧠 Business Problem

Hotel operators and revenue managers face challenges such as:
- Identify high-value and loyal customer segments.
- Understanding cancellation drivers and booking behavior.
- Measuring hotel performance relative to competitiors.
- Tracking market share shifts and growth trends.
- Optimizing distribution channe;s, pricing and room mix.
Without structured analysis, decisions around pricing, channel strategy, and customer targeting risk being intuition-driven rather than data-driven.

## 🎯 Objectives 

- Analyze customer trends, demographics and loyalty patterns
- Understand booking behavior, seasonality and cancellations.
- Evaluate hotel performance, rankings, and growth.
- Measure market positioning and revenue-based market share.
- Translate analytical findings into actionable business insights.

## 📖 Dataset

The dataset simulates hotel booking sales in Dubai, originally sourced from Kaggle, with additional fictional customer, agent, country codes, hotels, meals and rooms tables created manually to enhance analysis. Key fields include:
- Booking transactions
- Rooms data
- Hotel info
- Customer demographics
- Agent details

## 🧰 Tools Used

- MySQL - Data aggregation, window funtions, ranking, recursive ctes and multi bucket ctes.
- Power BI - For data modelling and building interactive dashboards.
- DAX - Rankings, YoY, occupancy.
- Excel - Initial data inspection, validation, and creation of dimension data.

## 📁 Database

To facilitate data management and analysis, a database on MySQL was created to store the dataset. In Power BI, a star schema was created to improve organization and efficiency of queries.

## 📂 Database Structure

The MySQL database contains 7 related tables:

### 1. dim_Country_Codes                
| Column  | Description              |
|---------|--------------------------|
| Abbrev  | 3 character country code |
| Country | Country name             |
| Long    | Longitude                | 

### 2. dim_Customer_Details
| Column     | Description          |
|------------|----------------------|
| Id         | Unique Customer ID   |
| First_name | Customer first name  |
| Last_name  | Customer last name   |
| Gender     | Gender (Male/Female) |
| Age        | Customer age         |
| Country    | Country of origin    |

### 3. dim_Agent_Company_Details
| Column      | Description                                | 
|-------------|--------------------------------------------|
| Agent_id    | Unique agent ID                            |
| First_name  | Agent first name                           |
| Last_name   | Agent last name                            |
| Gender      | Agent gender                               |
| Client_Name | Company represented                        |
| Type        | Agent type (Corporte, GDS, TA/TO, Self-Web)|
| Location    | Agent country of origin                    |

### 4. dim_Hotel_details
| Column     | Description                              | 
|------------|------------------------------------------|
| Hotel Name | Name of the hotel                        |
| Location   | Hotel Location                           |
| Stars      | Average hotel customer rating (out of 5) |
| Rooms      | Rooms available (Assiming constant       |
| Brand      | Company of the hotel                     |
| Type       | Hotel type (City Hotel/Resort Hotel      |

### 5. dim_Meal_details
| Column       | Description                         | 
|--------------|-------------------------------------|
| Meal Plan    | 2 char code of the plan             |
| Full Form    | Full form of the meal               |
| Description  | Explanation of the meal plan        |
| Average Rate | Average meal cost                   |
| Type         | Hotel type (City Hotel/Resort Hotel |

### 6. dim_Room_details
| Column        | Description                            | 
|---------------|----------------------------------------|
| Code          | Room code                              |
| Room Category | Hotel name                             |
| Avg Area      | Area of the room                       |
| Bedrooms      | No of bedrooms                         |
| Bed Type      | Size of bed                            |
| View          | Room view                              |
| Wi-Fi         | Wi-Fi availability (Yes/No)            |
| Balcony       | Balcony availability (Yes/No/Optional) |
| Bathtub       | Bathtub availability (Yes/No/Roll-in)  |
| Lounge Access | Access to lounge (Yes/No               |

### 7. Fact_Hotel_bookings
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

