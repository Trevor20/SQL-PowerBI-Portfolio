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
| Average Rate | Average meal cost (in AED)          |
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
| Column                          | Description                                              |
|---------------------------------|----------------------------------------------------------|
| Sales_id                        | Unique booking transaction                               |
| Customer                        | Customer Id                                              |
| Hotel                           | Name of the hotel                                        |
| Hotel_type                      | Type of hotel (Resort Hotel/City Hotel)                  |
| Is_cancelled                    | Whether customer cancelled. 0 = No, 1 = Yes              |
| Lead_time                       | Days between booking date and arrival date               |
| arrival_date_year               | Year of arrival                                          |
| arrival_date_month              | Month of arrival                                         |
| arrival_date_week_number        | Week number of arrival (52-week format)                  |
| arrival_date_day_of_month       | Day of arrival (Month based)                             |
| stays_in_weekend_nights         | No of weekend nights stayed                              |
| stays_in_week_night             | No of week nights stayed                                 |
| adults                          | No of adults (18+)                                       |
| children                        | No of children (8+)                                      |
| babies                          | No of babies (<8)                                        |
| meal                            | Meal chosen                                              |
| Country                         | Customer's country of origin                             |
| Market_segment                  | Type of hotel market (Direct, Corporate, Online TA, etc) |
| Distribution_channel            | Touchpoint used to make the booking                      |
| Is_repeating_guest              | Whether customer stayed before (0 = No, 1 = Yes          |
| Previous_cancellations          | No of previous cancellations                             |
| previous_bookings_not_cancelled | No of previous bookings not cancelled                    |
| reserved_room_type              | Room type reserved at booking                            |
| assigned_room_type              | Room type received at Check-in                           |
| booking_changes                 | No of booking changes                                    |
| deposit_type                    | Type of deposit (No Deposit, Non Refund, Refundable      |
| agent                           | Agent id who provided the booking                        |
| company                         | Client Name                                              |
| days_in_waiting_list            | Days in waiting before getting a comfirmed booking       |
| customer_type                   | Type of customer (Transient, Contract, Group)            |
| adr                             | Average daily rate of the room                           |
| required_car_parking_spaces     | No of parking spaces required by the customer            |
| total_of_special_request        | No of special requests made                              |
| reservation_status              | Reservation Status (Check-Out/Cancelled/No-Show          |
| reservation_status_date         | Latest date the booking status was updated               |

## 🔍 Key Business Questions Answered

## Part 1: Customer Trends & Demographics
1. What is the distribution of customers by market segments and top origin countries?
2. Which customer demographics contribute the most to revenue and ADR?
3. How do high-frequency vs low-frequency customers differ in spend and ADR?
4. Who are the top B2B client types, and how do they differ between resort and city hotels?
5. Which customer segments deliver the most stable and operationally efficienct revenue?

## Part 2: Booking Patterns & Behavior
1. What are the monthly booking and revenue trends across the years?
2. How do lead time, deposit type, distribution channel and booking changes affect cancellation likelihood?
3. Which distribution channels and market segments generate the highest ADR and occupancy?
4. Which customer types drive revenue within each booking channel?
5. Who are the top booking agents by bookings, ADR and cancellation rate?

## Part 3: Popularity, Market Positioning & Revenue Performance
1. Which hotels consistently rank highest in revenue, ADR, and bookings?
2. How does a hotel's global revenue rank differ from its rank within each market segment?
3. Which hotels show the highest YoY growth in ADR and completed bookings?
4. How does top 5 hotel's revenue-based market share evolve over time?
5. What are the top-performing room types (revenue, ADR, bookings) for each hotel segment?

## ➡️ Project Approach

### 1. Extract, Transform, Load, and Analysis using MySQL
1. Created a SQL database and loaded the CSV datasets using Table Data Import Wizard. 
2. Cleaned data by addressing incorrect date formats, replaced redundant text-based values with Unique ids to initiate faster querying through relational joins.
3. Deleted unnecessary columns to increase efficiency of data structure.
4. Build a star schema with primary and foreign key relationships.
5. Conducted initial data analysis using SQL queries, including CTEs, Joins and window functions.

### 2. Data Visualatization Using Power BI
Used appropiate visuals per business question, including:
1. Line + column charts for trends.
2. Stacked area visuals for market share.
3. Scatter plots for cancellation drivers
4. Ranking visuals for competitive positioning

Visuals were focused on interpretability and decision-making, not just visually appealing. 

## 🏆 Final Insights
- ☕ Colombian coffee is the best-selling product, and Hail is the highest performing city.
- 📆 Sales spike on Monday and Friday, likely due to start/end of workweek.
- 🏪 All stores perform similarly in gross profit, indicating consistent operations.
- 📈 Discounts have a positive correlation with net sales, especially among female customers.
- 🕵️‍♀️ Top 5 customers alone contribute significantly to total revenue, highlighting potential for loyalty programs.

