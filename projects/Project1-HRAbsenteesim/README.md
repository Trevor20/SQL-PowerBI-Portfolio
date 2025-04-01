# Analysing Employee Absenteeism using SQL and Power BI

## 🚀 Project Overview

This project analyses absenteeism in the workplace using attributes like employee demographics, absenteeism reasons, lifestyle choices and compensation. Furthermore, the HR department wantes to promote healthy lifestyle among the employees by providing incentives like bonus. Thus, the HR department also wants information regarding the healthy employees. Data is analyzed and information regarding healthy employees are extracted using SQL. The absenteeism in the workplace is analyzed and presented in Power BI using interactive dashboards.

## 🎯 Objectives 

1. HR wants the following regarding healthy individuals
   - Provide a list of healthy individuals and low absenteeism for a health bonus program.
   - Calculate wage increase for non-smokers - budget $983,221
3. Create a dashboard to understand absenteeism at work. It consists of
   - Absenteeism Overview - Key trends, Absenteeism Distribution and top reasons for being absent 
   - Absenteeism Factors - Analysis of how compensation, disciplinary failure and social lifestyle (Smoker, Drinker, BMI and no of degrees, pets and children) impact absenteeism.

## 📖 Dataset

The dateset in this project contains information about employee demographics, reasons for being absent and compensation rates. The dataset includes information like compensation/hr, age, reasons for being absent, no of hours absent, absent day/month, etc

## 📁 Database

The database was created in MySQL and the dataset was imported. The questions from HR was answered using SQL queries. A View was created in MySQL with relevant data required for absenteeism analysis. The view was connected to Power BI and an interactive dashboard was created.

## 📂 Database Structure

The Database contains 3 table 

### 1. Compensation
| Column  | Description                    |
|---------|--------------------------------|
| Id      | Unique employee Id             |
| Comp/hr | Compensation per hour ($/hour) |


### 2. Absent_Data
| Column | Description             |
|--------|-------------------------|
| Number | Unique Reason Id        |
| Reason | Reason for being absent |


### 3. Absent_Data
| Column                          | Description                                   |
|---------------------------------|-----------------------------------------------|
| Id                              | Unique Employee Id                            |
| Reason for absence              | Reason Id                                     |
| Month of Absence                | Month the employee was absent                 |
| Day of the week                 | Day the employee was absent                   |
| Seasons                         | Source had no info, data is ambiguous         |
| Transportation expense          | Cost to travel from home to office            |
| Distance From residence to work | Distance to work                              |
| Service time                    | Source had no info, data is ambiguous         |
| Age                             | Age of employee                               |
| Work load average/day           | Source had no info, data is ambiguous         |
| Hit target                      | Source had no info, data is ambiguous         |
| Disciplinary failure            | Whether employee had performance issues (0/1) |
| Education                       | No of education degrees                       |
| Son                             | No of Children                                |
| Social Drinker                  | Whether the employee drinks (1/0)             |
| Social Smoker                   | Whether the employee smokes (1/0)             |
| Pet                             | No of pets                                    |
| Weight                          | Employee weight                               |
| Height                          | Employee height                               |
| Body mass index                 | Division of weight by height                  |
| Absenteeism time in hours       | Total hours the employee was absent           |

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

