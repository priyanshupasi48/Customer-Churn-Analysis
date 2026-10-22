    ---------------DATA ANALYTICS PROJECT -- CUSTOMER CHURN ANALYSIS -- README.md---------------

 # Customer Churn Analysis

## Project Overview

Customer churn is a major challenge for telecom companies because losing customers can reduce revenue and increase customer acquisition costs. This project analyzes customer data to identify churn patterns, understand which customer segments are more likely to leave, and recommend strategies to improve customer retention.

The project uses Python, Excel, SQL, and Power BI to clean, analyze, and visualize customer data and transform it into actionable business insights.

## Business Problem

**Why are customers leaving the telecom company, which customer segments have the highest churn rates, and what actions can the company take to improve customer retention and reduce revenue loss?**

## Project Objectives

- Analyze overall customer churn and retention rates.
- Identify customer segments with high churn rates.
- Analyze churn based on contract type, tenure, gender, senior citizen status, internet service, and payment method.
- Compare average monthly charges for churned and retained customers.
- Build an interactive Power BI dashboard.
- Provide actionable business recommendations to improve customer retention.

## Tools and Technologies

- **Python:** Data cleaning, exploratory data analysis (EDA), and visualization.
- **Excel:** Data inspection and preliminary analysis.
- **SQL (MySQL):** Data quality checks, aggregation, and churn analysis.
- **Power BI:** Interactive dashboard, KPI cards, charts, and slicers.
- **Jupyter Notebook:** Exploratory data analysis and visualizations.
- **VS Code:** Project development and file management.

## Project Workflow

1. **Data Collection:** Load the telecom customer churn dataset.
2. **Data Cleaning:** Inspect missing values, duplicates, data types, and inconsistencies.
3. **Exploratory Data Analysis:** Explore customer behavior and churn patterns.
4. **SQL Analysis:** Perform data quality checks and calculate churn metrics by customer segment.
5. **Dashboard Development:** Create an interactive Power BI dashboard.
6. **Insight Generation:** Identify high-risk customer segments and potential causes of churn.
7. **Business Recommendations:** Suggest data-driven strategies to improve customer retention.

## Key Performance Indicators (KPIs)

The Power BI dashboard focuses on the following KPIs:

- **Total Customers:** Total number of customers in the dataset is 7043.
- **Churned Customers:** Number of customers who discontinued their service is 1869.
- **Churn Rate:** Percentage of customers who discontinued their service is 26.54%.
- **Retention Rate:** Percentage of retained customers who remained with the company is 73.46%.
- **Average Monthly Charges (Churned customers):** Average monthly charges of churned customers is $73.44.
- **Average Monthly Charges (Retained customers):** Average monthly charges of retained customers is $61.27.
### KPI Formulas

**Churn Rate**

Churn Rate = (Churned Customers / Total Customers) × 100

**Retention Rate**

Retention Rate = (Retained Customers / Total Customers) × 100


## Dashboard Analysis

The Power BI dashboard explores the following areas:

1. **Churn by Contract**: The churn by contract chart shows the percentage of churn by 
    Month-to-Month -- 42.71 % 
    One Year -- 11.27 % 
    Two Year -- 2.83 %


2. **Churn by Tenure**: The churn by tenure chart tells how churn varies with customer tenure.
     The churn by tenure shows the churn customers are 
     0-12 Months -- 1037
     13-24 Months -- 294
     25-48 Months -- 325
     49+ Months -- 213


3. **Churn by Payment Method**: Payment methods associated with higher churn.
     Payment Method      Churn Percentage 
     Electronic Check       45.29 %
     Mailed Check           19.11 %
     Bank Transfer          16.71 %
     Credit Card            15.24 %
4. **Churn by Internet Service**: Churn across internet service categories.
    Fiber Optic  -- 1297 Churned Customers -- 69.41 % churn rate
    DSL --  459 Churned customer -- 24.56 % churn rate 
    No internet service -- 113 Churned Customer --  6.05 % churn rate 

    
5. **Churn by Senior Citizen Status**: The churn by Senior Citizen Status

Non-Senior Citizen      |      Non-Senior Citizen 
Churn -- No                    Churn -- Yes
Total Customer -- 4508         Total Customer -- 1393 
Percentage -- 76.39 %          Percentage -- 23.6 % 

Senior Citizen          |      Senior Citizen
Churn -- No                    Churn -- Yes
Total Customer -- 666          Total Customer -- 476
Percentage -- 58.32 %          Percentage -- 41.68 %

6. **Average Monthly Charges by Churn Status**: The average monthly charges of churned and retained customers.

Churned Customer Average Monthly Charges -- $ 74.44 
Retained Customer Average Monthly Charges -- $ 61.27 


## Key Business Insights

The following are areas investigated in the analysis. 

- **Contract Type:** Month-to-Month contract category has the highest churn rate.
- **Customer Tenure:** Investigate whether newer customers are more likely to leave.
- **Payment Method:** Electronic check payment method is associated with higher churn rates.
- **Internet Service:**  Fiber Optic  -- 1297 Churned Customers -- 69.41 % churn rate
    DSL --  459 Churned customer -- 24.56 % churn rate 
    No internet service -- 113 Churned Customer --  6.05 % churn rate 

- **Customer Demographics:**Churn differences by gender and senior citizen status.

   Female -- Churn Rate -- 26.92 %
   Male -- Churn Rate -- 26.19 %

   Senior Citizen - Churn Rate -- 41.68 %
   Non-Senior Citizen - Churn Rate -- 23.61 %

- **Monthly Charges:** Average monthly charges differ between churned and retained customers.

    Average Monthly Charges of Churned Customers -- $72.65
    Average Monthly Charges of Retained Customers -- $61.50

## Business Recommendations

Based on the patterns confirmed by the analysis, the company could consider the following actions:

- **Improve Early Retention:** Introduce onboarding support and follow-up communication for new customers if early-tenure churn is high.
- **Encourage Longer Contracts:** Offer suitable incentives for customers who choose longer-term contracts if month-to-month customers show higher churn.
- **Review Payment Experience:** Investigate billing issues and payment friction for customer groups with elevated churn.
- **Personalize Retention Offers:** Design targeted retention campaigns for high-risk customer segments.
- **Review Pricing and Value:** Assess whether customers with higher monthly charges receive sufficient value for their spending.
- **Monitor Churn Regularly:** Track churn rate and retention KPIs over time to measure the effectiveness of retention strategies.

## Expected Business Impact

The analysis can help the company:

- Identify customers at greater risk of leaving.
- Understand customer behavior and churn patterns.
- Make more informed customer retention decisions.
- Develop targeted retention campaigns.
- Reduce avoidable customer loss and protect recurring revenue.


## Conclusion

This project demonstrates how data analytics can be used to investigate customer churn, uncover patterns in customer behavior, and support business decision-making.
By combining Python, Excel, SQL, and Power BI, the project provides a structured approach to data cleaning, analysis, visualization, and business recommendations.


**Data Analytics Portfolio Project**

Skills demonstrated: Python | Excel | SQL | Power BI | Data Cleaning | Exploratory Data Analysis | Data Visualization | Business Insights

