# Air Traffic Analysis in USA from 2000-2009 using Power BI

## 🚀 Project Overview

This project focuses analysing air traffic across the US from 2000 to 2009. It presents key insights into passenger traffic, flight occupancy, route popularity and state-wise aire travel distribution. It helps stakeholders understand travel demand, airport performance, and flight patterns over the years.

## 🎯 Objectives 

- Analyse passenger traffic trends over the years
- Evaluate route and airport popularity
- Assess seat utilization and efficiency
- Assess most common flight purposes
- Gather popularity of regions within the US by analysing total incoming and outgoing passenger traffic

## 📖 Dataset

The dateset in this project contains information about air travel. The dataset was initially collected from Kraggle and contains over 2 million datapoints. The dataset includes information like flight date, total flights, route, total passengers, empty seats, etc.

## 📁 Database

To Dataset was directly imported into Power BI. The dataset was cleaned in Power Query by removing redundance columns and empty rows. A new table called routes was created that contained information about airport location and population of the city it was located

## 📂 Database Structure

The final Dataset contains 2 tables 

### 1. Airports
| Column     | Description                                                                  |
|------------|------------------------------------------------------------------------------|
| Airport    | 3 Character Airport Name                                                     |
| Population | Population of the city where the airport is located                          |
| City       | City in which the airport is located                                         |
| State      | State in which the airport is located                                        |
| Country    | United States, added to ensure Power BI knows everything is restricted to US |

### 2. Flights
| Column               | Description                                                    |
|----------------------|----------------------------------------------------------------|
| Id                   | Unique Flight Id                                               |
| Origin_Airport       | Airport from which the plane departed                          |
| Destination_Airport  | Airport to which the plane landed                              |
| Passengers           | Total passengers who travelled                                 |
| Seats                | Total available seats                                          |
| Flights              | Total number of flights that travelled that route on that date |
| Distance_per_Flights | Distance from origin to destination                            |
| Fly_Date             | Date the flight took place                                     |
| Purpose              | Purpose of the flight (Commercial, Cargo, Other)               |
| Total Distance       | Total distance travelled by all flights                        |
| Route                | Origin to destination in format (Origin-->Destination)         |

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


