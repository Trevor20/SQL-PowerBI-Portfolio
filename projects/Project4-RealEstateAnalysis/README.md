# Real Estate Analysis in The UAE using SQL and Power BI

## 🚀 Project Overview

This project analyzes real estate listings data using SQL for data manipulation and Power BI for interactive visualizations. The goal is to derive insights into listing characteristics across different cities in the UAE, listing and price trends over time.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project4-RealEstateAnalysis/report)

## 🧠 Business Problem

Real estate market in UAE is really competitive. Investors in this market wants to understand apartment listing trends and characteristics across cities in UAE in order to better target rental opportunities in the future. 

## 🎯 Objectives 

- Analyse listing patters during the day and during the week
- Evaluate apartment characeristics across major cities in the UAE
- Study price trends as apartment characteristics change
- Analyse distribution of apartment listings across the UAE to understand where most apartments are located

## 📖 Dataset

The dateset in this project contains information about apartment listings in UAE. The dataset was collected from Kraggle, which contained imformation about listings posted on different listing sites. The dataset includes data about apartment location, date posted and apartment characteristics(bedrooms, bathrooms, furnished/unfurnished).

## 🧰 Tools Used

- MySQL - For data extraction, cleaning and transformation
- Power BI - For visualization and report building
- DAX - For creating calculated measures and KPIs
- Data Modelling - For creating relationships between tables 

## 📁 Database

To facilitate data management and analysis, a database on MySQL was created to store the dataset. The CSV file was imported into the database.

## 📂 Database Structure

The database contains 1 table 

### 1. real_estate
| Column         | Description                                   |
|----------------|-----------------------------------------------|
| Apt_Id         | Unique Apartment Id                           |
| DisplayAddress | Location of the apartment                     |
| Bathrooms      | No of bathrooms                               |
| Bedrooms       | No of bedrooms                                |
| AddedOn        | Date the listing was added to the website     |
| Type           | Type of apartment                             |
| Price          | Cost to purchase                              |
| Verified       | Whether Apartment is verified listing(Yes/No) |
| priceDuration  | Whether the listing is listed for sale or rent|
| SizeMin        | Area of the apartment (in Sqft)               |
| Furnishing     | Whether Apartment is furnished(Yes/No)        |

## 🔍 Key Business Questions Answered

1. What times during the day are apartment listings most frequently added?
2. Which days of the week see the highest number of listings?
3. What are the average characteristics of an apartment across cities in UAE?
4. Does price change with changes in apartment characteristics (area, bathrooms, furnished/unfurnished)?
5. What is the distribution of verified listings across apartment types?
6. What is the distribution of total listings across different cities in the UAE?

## ➡️ Project Approach

### 1. Extract, Transform, Load, and Analysis using MySQL
1. Created a SQL database and tables, and loaded data from CSV files into the database using Table Data Import Wizard.
2. Since displayAddress column has full addresses of the listings, it was difficult to do city wise analysis. Thus a new table called location was created that contains full addresses of the listings. Then, city and district was extracted from the full addresses and placed in city and district columns respectively.   
3. Cleaned data by replacing redundant text-based displayAddress values with Unique ids in location table in order to initiate faster querying through relational joins.
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
- Most of the listings are added around morning between 7 am to 12 pm.
- Area seems to increase approximately linearly with no of bedrooms.
- Studio, 1-bedroom and 2-bedroom make up for majority of the listings.
- In smaller apartments, the prices dont differ much between furnished and unfurnished. However, difference is noticeable for larger apartments like luxury and duplex/triplex apartments.
