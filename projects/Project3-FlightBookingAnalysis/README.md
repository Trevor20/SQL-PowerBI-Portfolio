# Flight Booking Analysis using SQL & Power BI

## 🚀 Project Overview

This project explores historical flight booking data to uncover patterns in passenger behavior, booking methods, popular destinations and flight-related preferences. The goal is to help the airline understand customer preferences and optimize marketing and operational strategies.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project3-FlightBookingAnalysis/report)

## 🎯 Objectives 

- Analyse weekly booking trends.
- Assess preferred flight hours and booking days.
- Evaluate customer preferences for trip type and booking channels.
- Identity key market segments by booking origin and travel behavior.

## 🧠 Business Problem

An Airline wants to understand customer behavior and booking patterns to improve marketing campaigns and operational efficiency. Key stakeholders are interested in analyzing booking volume, customer preferences in booking flights and extra services, and identifying major booking sources by geography.

## 📖 Dataset

The dataset represents booking-level data collected by an airline. Each row in the dataset corresponds to a single booking, which may include one or more passengers. The dataset was collected from Kraggle and contains 50k datapoints. The dataset includes information like no of passengers in the booking, type of trip, flight duration, routes, etc.

## 🧰 Tools Used

- MySQL - Data load and initial analysis before building dashboards
- Power BI - For building interactive dashboards
- Power Query Editor - Data transformation using M language
- DAX - Creating date table, calculated measures and KPI calculation

## 📁 Initial Analysis in SQL

To facilitate initial data analysis before building a dashboard, a database was created in MySQL and a flat table was imported into the database. An initial exploratory analysis was conducted in SQL to gain early insights before importing the data into Power BI.

## 📂 Dataset Structure

One table was created in MySQL

### 1. Customer_Booking
| Column                | Description                                                 |
|-----------------------|-------------------------------------------------------------|
| Num_passengers        | No of passengers included in the booking                    |
| Sales_channel         | Whether passenger used mobile or internet to book           |
| Trip_Type             | Round or one way trip                                       |
| Purchase_Lead         | Days between ticket purchase and flight day                 |
| Length_Of_Stay        | No of days the passengers will stay at the destination      |
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
3. what are the most popular destinations, and what is the average flight duration?
4. At what time of the day do passengers prefer to travel?
5. At what day of the week do passengers prefer to book flights?
6. Is there a correlation between extra service selection and flight duration?
7. What is the preferred method for booking flights (Mobile app vs website)?
8. What kind of flights do passengers typically book (one-way vs round trip)?
9. Which countries generated the most bookings?

## ➡️ Project Approach

### 1. Data Load, and Exploration using MySQL
- Created a database and loaded CSV data using Table Data Import Wizard.
- Conducted initial data analysis using SQL queries, including CTEs and Joins.

### 2. Data Cleaning and Transformation using Power Query Editor
- Data load - The table was directly loaded into Power BI.
- Added Index column - To track number of bookings.
- Split "Route" column - Split it into "Origin" and "Destination". Deleted the route column for redundancy.
- Added "Total extra services" column - To check total no of extra services (extra baggage, preferred seat, in-flight meal) chosen in the booking.
- Rename columns - For better clarity and consistency.

### 3. Data Visualization Using Power BI
- Overview - Summary of relevant KPIs like completed bookings, most popular destinations and average flight duration.
- Time-series analysis - Determines times that passengers prefer to booking flights and fly.
- Passenger preference - Indicates most preferred choice of booking flights and trip type.
- Market trends - To find top countries where majority of their customers book flights.
- Extra services - To determine whether passengers opt for more extra services as flight duration increases.

## 🏆 Final Insights
- 📉 Only 14.96% of total bookings were completed, highlighting potential for improved converion through better UX or marketing.
- ✈️ Passengers prefer to travel between 8 am to 12 pm.
- 📆 Mondays see the highest booking volume, while Saturdays see the least.
- 📈 There is a very slight positive correlation between flight duration and number of flights. This suggest the number of extra services does not really depend on flight duration. 
- 👱 Most passengers prefer booking round-trip flights through the internet(website). 

