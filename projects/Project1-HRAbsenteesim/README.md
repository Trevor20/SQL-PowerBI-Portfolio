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
| Body mass index                 | Division of weight by height. Also called BMI |
| Absenteeism time in hours       | Total hours the employee was absent           |

## 🔍 Key Business Questions Answered

1. What is the list of healthy individuals and low absenteeism for a health bonus program?
2. Calculate wage increase for non-smokers. Budget is $983,221.
3. How does the no of employees absent vary during the year and during the week?
4. How does total absent hours vary by age of the employee?
5. What is the distribution of employees absent according to BMI?
6. What are the top reasons due to which employees take leave?
7. Is there a correlatiion between compensation/hr and hours absent?
8. So social factors (Smoker, drinker, no of education degrees, children and pets) influence absenteeism?
9. Does having a disciplinary failure impact hours absent?
10. Does BMI category impact hours absent?

## ➡️ Project Approach

### 1. Data Transformation and Visualatization Using Power BI
Cleaned the data by removing redundand columns and creating a airports tables with airpo

### 2. Data Transformation and Visualatization Using Power BI
Cleaned the data by removing redundand columns and creating a airports tables with airport information like population and location. Then created the following main sections of the dashboard to gather insights
1. Overview - Summary of relevant KPIs like total passengers, longest route, % unoccupied seats per flight, flight distance per route, etc
2. Time-series analysis - tracks how passenger traffic evolved over the years
3. Airport popularity - graphs that highlight the busiest airports an popular flight routes
4. Market trends - Donut chart that indicates the most common purpose of travel
5. Region wise analysis - Heatmap that indicates top states in the US that have the most passenger traffic (incoming and outgoing)

## 🏆 Final Insights
- Non-Smokers have a wage increase of approx $1433.
- March has the month with the highest employees being absent
- Employees are redundant to take leave on Thursday, with least employees taking leave.
- Form BMI perspective, more than half of employees who took leave where healthy
- Significant absent hours came from the age group 31-34.
- Medical and dental consultations make up majority of the reasons employees take leave.
- There is a slight correlation between compensation/hr and absent hours
- No one who had a disciplinary failure took leave
- Most of the absent hours came from employees who only drinks, but not smokes.

