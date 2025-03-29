# Airline Booking Analysis Using SQL and Power BI

## 🚀 Project Overview

This project focuses on analysing airline booking data to uncover passengeer booking trends, preferred booking methods, popular destinations and flight-related preferences. 

## 🎯 Objectives 

- Analyse passenger booking trends
- Understad passenger travel preferences
- Evaluate booking behavior
- Identify key market segments

## 📖 Dataset

The dateset in this project contains information about flight bookings. The dataset was initially collected from Kraggle and contains 50k datapoints. The dataset includes information like no of passengers who booked, type of trip, flight duration, routes, etc.

## 📁 Database

To facilitate data management and analysis, a database on MySQL was created to store the dataset. MySQL provdies a robust method to organize and manipulate data. Another table was created to store all the combination of routes.

## 📂 Database Structure

The final Dataset contains 2 tables 

### 1. Routes
| Column      | Description        |
|-------------|--------------------|
| Id          | Unique routw Id    |
| Origin      | Flight origin      |
| Destination | Flight destination |

### 2. Bookings
| Column                | Description                                   |
|-----------------------|-----------------------------------------------|
| Booking_id            | Unique booking Id                           |
| Sales_channel         | Whether passenger used mobile or internet to book |
| Trip_Type             | Round or one way trip                               |
| Purchase_Lead         | Days between ticket purchase and flight day                         |
| Lenght_Of_Stay        | Date the listing was added to the website     |
| Flight_hour           | Type of apartment                             |
| Flight_Day            | Cost to purchase                              |
| Route                 | Whether Apartment is verified listing(Yes/No) |
| Booking_origin        | Area of the apartment (in Sqft)               |
| Wants_extra_baggage   | Whether Apartment is furnished(Yes/No)        |
| Wants_preferred_seat  |
| Wants_in_flight_meals |
| Flight_Duration       |
| Booking_complete      |

## 🔍 Key Business Questions Answered

1. What time of day are apartment listings most frequently added?
2. which days of the week see the highest number of listings?
3. What are the average characteristics of an apartment across cities in UAE?
4. How does price change with area?
5. How does price change with apartment size and number of bathrooms?
6. How do prices differ between furnished and unfurnished apartments?
7. How do percentage of verified listings differ across apartment types?
8. What is the distribution of total apartments across different cities in the UAE?

## ➡️ Project Approach

### 1. Extract, Transform, Load, and Analysis using MySQL
1. Created a SQL database and tables, and loaded data from CSV files into the database using Table Data Import Wizard. 
2. Cleaned data by replacing redundant text-based values with Unique ids to initiate faster querying through relational joins.
4. Added primary and foreign keys to build a star-schema like relational design
5. Conducted initial data analysis using SQL queries, including CTEs and Joins.

### 2. Data Visualatization Using Power BI
Connected Power BI to MySQL Database through Direct Query and build the following visuals
1. Overview - Summary of relevant KPIs like total listings, percentage verified, price per sqft, etc.
2. City Analysis - table and graphs that show the average characteristics and total listings across cities in UAE
3. Time-series analysis - graphs that show the no of listings added over time, allows the viewer to see times when website is most active
4. Price trends - To study how price changes with changes in apartment characteristics like apartment type, furnishing and no of bedrooms
5. Listing analysis - to determine how many listings are verfied, and how do they change as apartment type changes. It also determines distribution of listings according to no of bedrooms and apartment type

## 🏆 Final Insights
- Only listings in Dubai and Abu Dhabi are verified, with Dubai having the majority of verfied listings.
- Monday, start of the week, has the most listings added.
- Most of the listings are added around morning from 7 am to 12 pm.
- Area seems to increase approximately linearly with no of bedrooms.
- Studio, 1-bedroom and 2-bedroom make up for majority of the listings.
- In smaller apartments, the prices dont differ much between furnished and unfurnished. However, difference is noticeable for larger apartments like luxury and duplex/triplex apartments.

