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

### 1. Flights
| Column                 | Description                                                    |
|------------------------|----------------------------------------------------------------|
| Origin_Airport         | Airport from which the plane departed (IATA 3 character format)|
| Destination_Airport    | Airport to which the plane landed (IATA 3 Character format)    |
| Passengers             | Total passengers who travelled                                 |
| Seats                  | Total available seats                                          |
| Flights                | Total number of flights that travelled that route on that date |
| Distance_per_flight    | Distance from origin to destination                            |
| Fly_Date               | Date the flight took place                                     |

## 🔍 Key Business Questions Answered

1. How has total passenger traffic evolved between 2000 and 2009?
2. Which 5 airports handled the highest passenger traffic?
3. What are the top 5 most popular flight routes based on total passengers?
4. What percentage of seats remained empty on flights over the years?
5. How many empty seats per flight were recorded on average?
6. What is the distribution of flights by purpose (commercial, cargo, other)?
7. Which 10 states had the highest passenger traffic (incoming and outgoing)?

## ➡️ Project Approach

### 1. Data Cleaning & Transformation using Power Query Editor
1. Removed Redundant Fields: Latitude and longitude columns were dropped due to many missing values and existance of city location.
2. Created Dimension Table: Airports: Includes airport name, city and city population. Removed the columns in airport_data that existed in airports table
3. Split Location Data: City fields were split into City, State, and Country to support geospatial visuals and to ensure Power BI correctly interprets U.S. cities. 
4. Derived Route Column: Created a new column in the format origin_airport-->destination_airport to analyse route popularity.
5. Categorized Flight Purpose: Created a new column "Purpose" that indicates the purpose of the flight. Flights with 0 passenger were tagged as "Cargo", while others were tagged "Commercial".

### 2. Data Visualatization Using Power BI
Created the following main sections of the dashboard to gather insights
1. Overview - Summary of relevant KPIs like total passengers, longest route, % unoccupied seats per flight, flight distance per route, etc.
2. Time-series analysis - tracks how passenger traffic evolved over the years.
3. Airport popularity - graphs that highlight top airports and popular flight routes.
4. Market trends - Donut chart that indicates the most common purpose of travel.
5. Region wise analysis - Heatmap of U.S. states based on total passenger traffic(incoming and outgoing).

## 🏆 Final Insights
- ✈️ Most popular route: Boston Logan International Airport (BOS) to (Daniel K. Inouye International Airport (HNL).
- ▶️ Average flight distance: 653.59 nautical miles.
- 💺 Average Unoccupied Seats per flight: 27.
- 🔄 Flights per route: 2,037 over 10 years.
- 📉 Passenger volume rose steadily until 2007, then declined sharply during the 2008 financial crisis.
- 🏗️ Flight Purpose - Over 95% of flights were commercial.
- 🌎 Top U.S. States by Traffic: California, Texas and Florida.
