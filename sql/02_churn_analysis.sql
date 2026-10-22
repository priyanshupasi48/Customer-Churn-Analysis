-- =====================================================
-- PROJECT: CUSTOMER CHURN ANALYSIS
-- FILE: 02 Churn Analysis
-- PURPOSE: Analysis of the data 
-- =====================================================


USE customer_churn_db;

-- Total customers, churned customers, and retained customers

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers
FROM telco_churn_cleaned;

-- Overall churn rate

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned;

-- Churn distribution

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM telco_churn_cleaned),
        2
    ) AS percentage
FROM telco_churn_cleaned
GROUP BY Churn;

-- Churn rate by contract

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY Contract
ORDER BY churn_rate_percentage DESC;

-- Churn by payment method

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY PaymentMethod
ORDER BY churn_rate_percentage DESC;

-- Churn by internet service

SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY InternetService
ORDER BY churn_rate_percentage DESC;

-- Churn by tenure group

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END
ORDER BY MIN(tenure);

-- Average tenure of churned vs retained customers

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(tenure), 2) AS average_tenure_months,
    MIN(tenure) AS minimum_tenure,
    MAX(tenure) AS maximum_tenure
FROM telco_churn_cleaned
GROUP BY Churn;

-- Churn by monthly charges

SELECT
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges < 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS charge_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage,
    ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charges
FROM telco_churn_cleaned
GROUP BY
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges < 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END
ORDER BY MIN(MonthlyCharges);


-- Monthly revenue associated with churned customers

SELECT
    COUNT(*) AS churned_customers,
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_at_risk,
    ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charge
FROM telco_churn_cleaned
WHERE Churn = 'Yes';

-- Compare charges for churned and retained customers

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM telco_churn_cleaned
GROUP BY Churn;

-- Churn by senior citizen status

SELECT
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY SeniorCitizen;

-- Churn by gender

SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY gender;

-- Churn by dependents and partner status

SELECT
    Partner,
    Dependents,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY Partner, Dependents
ORDER BY churn_rate_percentage DESC;

-- Churn by online security

SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY OnlineSecurity
ORDER BY churn_rate_percentage DESC;

-- Churn by tech support

SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY TechSupport
ORDER BY churn_rate_percentage DESC;

-- Churn by multiple service subscriptions

SELECT
    InternetService,
    OnlineSecurity,
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY InternetService, OnlineSecurity, TechSupport
HAVING COUNT(*) >= 20
ORDER BY churn_rate_percentage DESC;

 -- High-risk segment: month-to-month customers

SELECT
    Contract,
    CASE
        WHEN tenure <= 12 THEN 'New Customers'
        ELSE 'Established Customers'
    END AS customer_stage,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY
    Contract,
    CASE
        WHEN tenure <= 12 THEN 'New Customers'
        ELSE 'Established Customers'
    END
ORDER BY churn_rate_percentage DESC;


-- List individual churned customers for further investigation

SELECT
    customerID,
    tenure,
    Contract,
    MonthlyCharges,
    InternetService,
    PaymentMethod,
    TechSupport
FROM telco_churn_cleaned
WHERE Churn = 'Yes'
ORDER BY tenure ASC, MonthlyCharges DESC
LIMIT 100;

-- Churn by contract

USE Customer_churn_db;
SELECT 
	Contract,
    Churn,
    COUNT(*) AS total_customers
FROM telco_churn_cleaned
GROUP BY Contract, Churn
ORDER BY Contract, Churn;   
USE customer_churn_db;


SELECT
    Contract,
    PaymentMethod,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,
    ROUND(
        SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_cleaned
GROUP BY
    Contract,
    PaymentMethod,
    InternetService
ORDER BY
    churn_rate_percentage DESC; 
    
    -- Rank contract types by churn rate

    WITH contract_analysis AS (
    SELECT
        Contract,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
    FROM telco_churn_cleaned
    GROUP BY Contract
),
churn_rates AS (
    SELECT
        Contract,
        total_customers,
        churned_customers,
        100.0 * churned_customers
            / NULLIF(total_customers, 0) AS churn_rate
    FROM contract_analysis
)
SELECT
    Contract,
    total_customers,
    churned_customers,
    ROUND(churn_rate, 2) AS churn_rate_percentage,
    DENSE_RANK() OVER (ORDER BY churn_rate DESC) AS churn_rank
FROM churn_rates;

-- Compare each contract's churn rate with the overall rate

WITH overall AS (
    SELECT
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0) AS overall_churn_rate
    FROM telco_churn_cleaned
),
contracts AS (
    SELECT
        Contract,
        COUNT(*) AS total_customers,
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0) AS contract_churn_rate
    FROM telco_churn_cleaned
    GROUP BY Contract
)
SELECT
    c.Contract,
    c.total_customers,
    ROUND(c.contract_churn_rate, 2) AS contract_churn_rate,
    ROUND(o.overall_churn_rate, 2) AS overall_churn_rate,
    ROUND(c.contract_churn_rate - o.overall_churn_rate, 2)
        AS difference_in_percentage_points
FROM contracts c
CROSS JOIN overall o
ORDER BY difference_in_percentage_points DESC;





    
    
    
