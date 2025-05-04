# Real Estate Analysis in the UAE using SQL and Power BI

## 🚀 Project Overview

This project analyzes real estate listings data from the UAE using SQL for data transformation and Power BI for interactive dashboard creation. The goal is to derive trends in apartment characteristics, pricing, and listing behavious across major cities, providing valuable insights for real estate investor and analysts.

## [Report](https://github.com/Trevor20/SQL-PowerBI-Portfolio/tree/main/projects/Project4-RealEstateAnalysis/report)

## 🧠 Business Problem

The UAE's real estate market is highly competitive. Investors in this market wants to understand apartment listing trends and characteristics across cities in UAE in order to better target rental opportunities in the future. 

## 🎯 Objectives 

- Analyse listing trends by time of day and day of the week.
- Evaluate apartment characteristics across major UAE cities.
- Study price variations based on features like furnishing, size, and bedrooms.
- Understand the geographic distribution of listings and verified properties.

## 📖 Dataset

The dataset in this project contains information about apartment listings in UAE. The dataset was collected from Kaggle, which contained imformation about listings posted on different listing sites. The dataset includes data about apartment location, date posted and apartment characteristics(bedrooms, bathrooms, furnished/unfurnished).

## 🧰 Tools Used

- MySQL - For data cleaning, transformation and modeling.
- Power BI - For building interactive dashboards and visuals.
- DAX - For creating calculated measures and KPIs.
- Data Modelling - For creating relationships between tables.

## 📁 Database

A relational database was created in MySQL to improve data integrity and query efficiency. The original flat CSV file was normalized by extracting location components(city, district) into a seperate table and replacing full addresses with foreign keys.

## 📂 Database Structure

The database initially contains 1 table 

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

1. What times of day are listings most frequently added?
2. Which days of the week have the highest listing activity?
3. What are the average characteristics of an apartment across major cities in UAE?
4. Do apartment characteristics(area, bathrooms, furnished/unfurnished) affect price?
5. What is the distribution of verified listings across apartment types?
6. What is the distribution of total listings across different cities in the UAE?

## ➡️ Project Approach

### 1. Data Preparation and Initial Analysis with MySQL
1. Created a database and imported the CSV dataset using the Table Data Import Wizard.
2. Since displayAddress column has full addresses of the listings, it was difficult to do city wise analysis. Thus a new table called location was created that contains full addresses of the listings. Then, city and district was extracted from the full addresses and placed in city and district columns respectively.   
3. Cleaned data by replacing redundant text-based displayAddress values with Unique ids in location table in order to initiate faster querying through relational joins.
4. Added primary and foreign keys to build a star-schema like relational design
5. Conducted initial data analysis using SQL queries, including CTEs and Joins.

### 2. Data Visualization Using Power BI
Connected Power BI to MySQL Database through Direct Query and build the following visuals
1. Overview - Summary of relevant KPIs like total listings, percentage verified, price per sqft, etc.
2. City Analysis - Visuals that show the average characteristics and total listings across cities in UAE
3. Time-series analysis - Graphs that show the no of listings added over time, allows the viewer to see times when website is most active
4. Price trends - To study how price changes with changes in apartment characteristics like apartment type, furnishing and no of bedrooms
5. Listing analysis - To determine how many listings are verified, and how do they change as apartment type changes. It also determines distribution of listings according to no of bedrooms and apartment type

## 🏆 Final Insights
- ☑️ Only listings in Dubai and Abu Dhabi are verified, with Dubai having the majority of verified listings.
- 📆 Monday, start of the week, has the most listings added.
- 🕙 Most of the listings are added around morning between 7 am to 12 pm.
- ⚖️ Apartment area increases approximately lineraly with the number of bedrooms.
- 🏗️ Studio, 1-bedroom and 2-bedroom make up the majority of the listings.
- 🛏️ Furnishing has a minimal price impact in smaller apartments, but a significant price difference is observed in larger luxury apartments.
