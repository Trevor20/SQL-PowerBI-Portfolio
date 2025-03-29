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

1. What is the overall booking volume and passenger count?
2. What percentage of bookings were paid?
3. what is the most popular destination, and what is the average flight duration?
4. At what time of the day do passengers prefer to travel?
5. At what day of the week do passengers prefer to book flights?
6. Does the number of extra services corelate with the duration of the flight?
7. What is the preferred method for booking flights (Mobile app vs website)?
8. What kind of flights do passengers typically book (one-way vs round trip)?
9. What are the top 5 countries by passenger bookings?

## ➡️ Project Approach

### 1. Extract, Transform, Load, and Analysis using MySQL
1. Created a SQL database and tables, and loaded data from CSV files into the database using Table Data Import Wizard.
2. Added a routes table with origin and destination to distinguish between origin and destination.
3. Conducted initial data analysis using SQL queries, including CTEs and Joins.

### 2. Data Visualatization Using Power BI
Connected Power BI to MySQL Database through Direct Query and build the following visuals
1. Overview - Summary of relevant KPIs like completed bookings, most popular destinations and average fligt duration.
2. Time-series analysis - graphs that show times that passengers prefer to booking flights and fly
3. Passenger preference - graphs that indicate most preferred choice of booking flights and types of flights (one way of round trip)
4. Market trends - to find the top 5 countries where flights are booked to check locations of majority of their potenial customers.
5. Extra services potential - do passenger opt for more extra services as flight duration increases

## 🏆 Final Insights
- Only 14.96% of total bookings were completed, which suggests potential to push marketing efforts to increase completed bookings.
- Passengers prefer to travel from 8 am to 12 pm.
- Passengers book most of their flights on Monday, while the least bookings are on Saturday.
- While the no of extra services increases with increase in flight duration, the different is minimial with the difference between no services and 3 servies is about 36 minutes in flight duration.
- Most passengers book on the internet, and almost all passengers book round trip flights. 

