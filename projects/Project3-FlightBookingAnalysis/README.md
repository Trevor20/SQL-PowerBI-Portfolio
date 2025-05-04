# Airline Booking Analysis With SQL and Power BI

## 🚀 Project Overview

This project focuses on analysing airline booking data to uncover passenger booking trends, preferred booking methods, popular destinations and flight-related preferences.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project3-FlightBookingAnalysis/report)

## 🎯 Objectives 

- Analyse weekly booking trends.
- Assess hourly air traffic.
- Evaluate customer preferences for trip type and method of booking flights.
- Identity major customer market segments.

## 🧠 Business Problem

An Airline wants to understand customer behavior and route-level booking trends to improve marketing campaigns and operational efficiency. Key stakeholders are interested in analyzing booking volume, customer preferences with booking flights and in-flight services, and route popularity.

## 📖 Dataset

The dataset represents booking-level data collected by an airline. Each row in the dataset corresponds to a single booking, which may include one or more passengers. The dataset was collected from Kraggle and contains 50k datapoints. The dataset includes information like no of passengers in the booking, type of trip, flight duration, routes, etc.

## 🧰 Tools Used

- MySQL - Data load and initial analysis before building dashboards
- Power BI - For building interactive dashboards
- Power Query Editor - Data transformation using M language
- DAX - Creating date table, calculated measures and KPI calculation

## 📁 Database

To facilitate initial data analysis before building a dashboard on Power BI, a database was created in MySQL and a flat table was imported into the database. An initial data analysis was conducted in SQL to gain an understanding of the data

## 📂 Database Structure

One table was created in MySQL

### 1. Customer_Booking
| Column                | Description                                                 |
|-----------------------|-------------------------------------------------------------|
| Num_passengers        | No of passengers included in the booking                    |
| Sales_channel         | Whether passenger used mobile or internet to book           |
| Trip_Type             | Round or one way trip                                       |
| Purchase_Lead         | Days between ticket purchase and flight day                 |
| Lenght_Of_Stay        | No of days the passengers will stay at the destination      |
| Flight_hour           | Time the flight departs                                     |
| Flight_Day            | Day of the week the flight departs                          |
| Route                 | Origin to destination (in format OriginDestination          |
| Booking_origin        | Country from which the booking was done                     |
| Wants_extra_baggage   | Whether passenger/s want extra baggage (1/0 for Yes/No)     |
| Wants_preferred_seat  | Whether passenger/s chooses his/her seat (1/0 for Yes/No)   |
| Wants_in_flight_meals | Whether passenger/s want in-flight meal (1/0 for Yes/No)    |
| Flight_Duration       | Duration of flight (in hrs)                                 |
| Booking_complete      | Whether they completed the booking (1/0 for Yes/No)         |

## 🔍 Key Business Questions Answered

1. What is the overall booking volume and passenger count?
2. What percentage of bookings were completed?
3. what is the most popular destination, and what is the average flight duration?
4. At what time of the day do passengers prefer to travel?
5. At what day of the week do passengers prefer to book flights?
6. Does the number of extra services correlate with the duration of the flight?
7. What is the preferred method for booking flights (Mobile app vs website)?
8. What kind of flights do passengers typically book (one-way vs round trip)?
9. From which countries did the airline receive the most bookings?

## ➡️ Project Approach

### 1. Data Load, and Analysis using MySQL
1. Created a SQL database and tables, and loaded data from CSV files into the database using Table Data Import Wizard.
2. Conducted initial data analysis using SQL queries, including CTEs and Joins.

### 2. Data Cleaning and Transformation using Power Query Editor
1. Data load - The table was directly loaded into Power BI.
2. Added Index column - An index column was added to check number of bookings.
3. Split "Route" column - Split "Route" column into "Origin" and "Destination". Deleted the route column for redundancy.
4. Added "Total extra services" - To check total no of extra services (extra baggage, preferred seat, in-flight meal) chosen in the booking.
5. Rename columns - Renamed columns for better data reading for the user.

### 3. Data Visualization Using Power BI
1. Overview - Summary of relevant KPIs like completed bookings, most popular destinations and average flight duration.
2. Time-series analysis - Determines times that passengers prefer to booking flights and fly.
3. Passenger preference - Indicates most preferred choice of booking flights and trip type.
4. Market trends - To find top countries where majority of their customers book flights.
5. Extra services potential - To determine whether passengers opt for more extra services as flight duration increases.

## 🏆 Final Insights
- 📉 Only 14.96% of total bookings were completed, which suggests to increase marketing efforts to increase completed bookings.
- ✈️ Passengers prefer to travel from 8 am to 12 pm.
- 📆 Passengers book most of their flights on Monday, while the least is on Saturday.
- 📈 There is a slight positive correlation between flight duration and number of flights. This suggest the number of extra services does not really depend on flight duration. 
- 👱 Most passengers book on the internet, and almost all passengers book round trip flights. 

