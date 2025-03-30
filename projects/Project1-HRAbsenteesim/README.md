# Analysing Employee Absenteeism using SQL and Power BI

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

1. How has total passenger traffic evolved between 2000 and 20009?
2. Which 5 airports handled the highest passenger traffic?
3. What are the top 5 most popular flight routes based on total passengers?
4. What percentage of seats remained empty on flights over the years?
5. How many empty seats per flight were recorded on average?
6. What is the distribution of flights by purpose (commercial, cargo, other)?
7. Which 10 states had the highest passenger traffic (incoming and outgoing)?

## ➡️ Project Approach

### 1. Data Transformation and Visualatization Using Power BI
Cleaned the data by removing redundand columns and creating a airports tables with airport information like population and location. Then created the following main sections of the dashboard to gather insights
1. Overview - Summary of relevant KPIs like total passengers, longest route, % unoccupied seats per flight, flight distance per route, etc
2. Time-series analysis - tracks how passenger traffic evolved over the years
3. Airport popularity - graphs that highlight the busiest airports an popular flight routes
4. Market trends - Donut chart that indicates the most common purpose of travel
5. Region wise analysis - Heatmap that indicates top states in the US that have the most passenger traffic (incoming and outgoing)

## 🏆 Final Insights
- Boston Logan International Airport (BOS) to (Daniel K. Inouye International Airport (HNL) is the most popular route.
-  Average flight distance is 653.59 nautical miles.
-  There are about 27 unoccupied seats per flight.
-  Over 10 years, there are 2037 flights per route.
-  Passenger traffic had a steep increase till 2007 and then dramatically reduced from 2007-2009. This could be due to the financial crises of 2008
-  Over 95% of flights were commercial.
-  California, texas and florida had the most passenger traffic.

