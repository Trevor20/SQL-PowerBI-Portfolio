# U.S Domestic Air Traffic Analysis(2000-2009) with Power BI

## 🚀 Project Overview

This project focuses on analysing air traffic across the US from 2000 to 2009. It presents key insights into passenger traffic, seat occupancy, route popularity and state-wise air travel distribution. It helps stakeholders understand travel demand, airport performance, and flight patterns over the years.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project2-AirportAnalysis/report)

## 🧠 Business Problem

With increasing passenger demand and variable flight occupancy across The U.S, The Federal Aviation Administration (FAA) seeks to analyse major domestic routes in The US to optimize terminal usage, staffing and airplane seats across peak routes and airports.

## 🎯 Objectives 

- Analyse passenger traffic trends over the years.
- Evaluate popularity of routes, airports and regions.
- Assess seat utilization and efficiency.
- Assess most common flight purposes.
- Gather popularity of regions within the US by analysing total incoming and outgoing passenger traffic.

## 📖 Dataset

The dateset in this project contains information about air travel. The dataset was sourced from Kraggle and contains over 2 million records tracking U.S. domestic air traffic from 2000 to 2009. It includes attributes like flight dates, route details, passenger counts, seats available, and airport locations.

## 🧰 Tools Used

1. Power BI - For interactive dashboard creation and visual analytics.
2. Power Query Editor (M Language) - For data loading, cleaning and transformation.
3. DAX - For calculated columns, measures, and KPIs.
4. Data Modelling - Star Schema with related dimension tables. 

## 📁 Database Preparation & Modelling

The Dataset was loaded directly into Power BI and cleaned using Power Query Editor. Latitude and longitude fields were dropped due to redundancy. A new "Airports" dimension table was created to normalize airport data (name, city, state, and population). Additionally, route and purpose columns were derived to support route-level and purpose-based analysis.

## 📂 Database Structure

Below is the structure of the primary fact table used for analysis, after cleaning and transformation.

### 1. Airport_Data
| Column                 | Description                                                    |
|------------------------|----------------------------------------------------------------|
| Origin_Airport         | Airport from which the plane departed (IATA 3 character format)|
| Destination_Airport    | Airport to which the plane landed (IATA 3 Character format)    |
| Origin_City            | City in which the departure airport is located                 |
| Destination_City       | City in which arrival airport is located                       |
| Passengers             | Total passengers who travelled                                 |
| Seats                  | Total available seats                                          |
| Flights                | Total number of flights that travelled that route on that date |
| Distance               | Distance from origin to destination                            |
| Fly_Date               | Date the flight took place                                     |
| Origin_population      | Population of the city where the origin airport is located     |
| Destination_population | Population of the city where the destination airport is located|
| Org_airport_lat        | Latitude of the origin airport                                 |
| Org_airport_long       | Longitude of the origin airport                                |
| Dest_airport_lat       | Latitude of the destination airport                            |
| Dest_airport_long      | Longitude of the destination airport                           |

## 🔍 Key Business Questions Answered

1. How has total passenger traffic evolved between 2000 and 2009?
2. Which 5 airports handled the highest passenger traffic?
3. What are the top 5 most popular flight routes based on total passengers?
4. What percentage of seats remained empty on flights over the years?
5. How many empty seats per flight were recorded on average?
6. What is the distribution of flights by purpose (commercial, cargo, other)?
7. Which 10 states had the highest passenger traffic (incoming and outgoing)?

## ➡️ Project Approach

### 1. Data Cleaning and Transformation using Power Query Editor
1. Since latitude and longitude columns had many empty rows and Origin/destination city existed, having both latitude/longitude and city information is redundance. So, latitude/longitude columns were removed.
2. Created a new table Airports with information that were constant like airport name, city and population. Removed the columns in airport_data that existed in airports table
3. Since city columns contained states too, the city columns were split into city and state. Another column country was added to ensure Power BI knows cities are restricted to the US.
4. Added a new column routes with format as origin_airport-->destination_airport to analyse popular routes.
5. Added a new column purpose that indicates the purpose of the flight. Flights with 0 passenger tend to be cargo flights, while flights with at least 1 passenger tend to be commercial.

### 2. Data Visualatization Using Power BI
Created the following main sections of the dashboard to gather insights
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
