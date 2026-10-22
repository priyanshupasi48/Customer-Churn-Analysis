
-- =====================================================
-- PROJECT: CUSTOMER CHURN ANALYSIS
-- FILE: 01 Quality Checks
-- PURPOSE: Validate the quality of cleaned data
-- =====================================================

USE customer_churn_db;

-- 1. Check total number of rows
SELECT COUNT(*) AS total_rows
FROM telco_churn_cleaned;


-- 2. Check the table structure and column names
DESCRIBE telco_churn_cleaned;


-- 3. Preview the first 10 records
SELECT *
FROM telco_churn_cleaned
LIMIT 10;


-- 4. Check for duplicate customer IDs
SELECT customerID, COUNT(*) AS duplicate_count
FROM telco_churn_cleaned
GROUP BY customerID
HAVING COUNT(*) > 1;


-- 5. Check for NULL values in important columns
SELECT
    SUM(CASE WHEN customerID IS NULL THEN 1 ELSE 0 END)
        AS null_customer_ids,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END)
        AS null_churn_values,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END)
        AS null_contract_values,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END)
        AS null_monthly_charges,
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END)
        AS null_tenure_values
FROM telco_churn_cleaned;


-- 6. Check churn column categories
SELECT Churn, COUNT(*) AS customer_count
FROM telco_churn_cleaned
GROUP BY Churn;


-- 7. Check contract categories
SELECT Contract, COUNT(*) AS customer_count
FROM telco_churn_cleaned
GROUP BY Contract;


-- 8. Check invalid negative monthly charges
SELECT *
FROM telco_churn_cleaned
WHERE MonthlyCharges < 0;


-- 9. Check invalid negative tenure
SELECT *
FROM telco_churn_cleaned
WHERE tenure < 0;


-- 10. Check minimum and maximum numerical values
SELECT
    MIN(tenure) AS min_tenure,
    MAX(tenure) AS max_tenure,
    MIN(MonthlyCharges) AS min_monthly_charges,
    MAX(MonthlyCharges) AS max_monthly_charges
FROM telco_churn_cleaned;


-- 11. Check blank customer IDs
SELECT COUNT(*) AS blank_customer_ids
FROM telco_churn_cleaned
WHERE customerID IS NOT NULL
  AND TRIM(customerID) = '';


-- 12. Check whether customer IDs are unique
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customerID) AS unique_customer_ids
FROM telco_churn_cleaned;

-- 13. Check for duplicate complete records 

USE customer_churn_db;
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn,
    COUNT(*) AS duplicate_count
FROM telco_churn_cleaned
GROUP BY
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn
HAVING COUNT(*) > 1;

-- 14. Check invalid categorical values

SELECT *
FROM telco_churn_cleaned
WHERE
    (gender IS NOT NULL
     AND gender NOT IN ('Male', 'Female'))
 OR (Churn IS NOT NULL
     AND Churn NOT IN ('Yes', 'No'))
 OR (Contract IS NOT NULL
     AND Contract NOT IN (
         'Month-to-month',
         'One year',
         'Two year'
     ))
 OR (Partner IS NOT NULL
     AND Partner NOT IN ('Yes', 'No'))
 OR (Dependents IS NOT NULL
     AND Dependents NOT IN ('Yes', 'No'));
     
-- 15. Check invalid tenure ranges	
    
SELECT *
FROM telco_churn_cleaned
WHERE tenure < 0
   OR tenure > 72;
   
 -- 16. Check negative or unusually high total charges
 
SELECT *
FROM telco_churn_cleaned
WHERE TotalCharges < 0;

-- 17. Check invalid SeniorCitizen values

SELECT *
FROM telco_churn_cleaned
WHERE SeniorCitizen IS NOT NULL
  AND SeniorCitizen NOT IN (0, 1);

 -- 18. Check invalid monthly charges

SELECT *
FROM telco_churn_cleaned
WHERE MonthlyCharges IS NOT NULL
  AND (MonthlyCharges < 0 OR MonthlyCharges > 200);

 -- 19. Check blank values across important text columns

SELECT
    SUM(CASE WHEN TRIM(gender) = ''
             THEN 1 ELSE 0 END) AS blank_gender,
    SUM(CASE WHEN TRIM(Contract) = ''
             THEN 1 ELSE 0 END) AS blank_contract,
    SUM(CASE WHEN TRIM(PaymentMethod) = ''
             THEN 1 ELSE 0 END) AS blank_payment_method,
    SUM(CASE WHEN TRIM(Churn) = ''
             THEN 1 ELSE 0 END) AS blank_churn
FROM telco_churn_cleaned;

-- 20. Check the percentage of missing values

SELECT
    COUNT(*) AS total_rows,
    ROUND(
        100.0 * SUM(
            CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS total_charges_missing_pct,
    ROUND(
        100.0 * SUM(
            CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS monthly_charges_missing_pct,
    ROUND(
        100.0 * SUM(
            CASE WHEN tenure IS NULL THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS tenure_missing_pct
FROM telco_churn_cleaned;

-- 21. Check suspicious total charges for new customers

SELECT customerID, tenure, MonthlyCharges, TotalCharges
FROM telco_churn_cleaned
WHERE tenure = 0
  AND TotalCharges > 0;

-- 22. Check internet service category consistency

SELECT *
FROM telco_churn_cleaned
WHERE
    (InternetService = 'No'
     AND (
         OnlineSecurity <> 'No internet service'
         OR OnlineBackup <> 'No internet service'
         OR DeviceProtection <> 'No internet service'
         OR TechSupport <> 'No internet service'
         OR StreamingTV <> 'No internet service'
         OR StreamingMovies <> 'No internet service'
     ));


-- 23. Check payment method values


SELECT PaymentMethod, COUNT(*) AS customer_count
FROM telco_churn_cleaned
GROUP BY PaymentMethod
ORDER BY customer_count DESC;

-- 24. Check churn rate is between 0% and 100%

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN Churn IN ('Yes', 'No') THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS churn_rate_pct
FROM telco_churn_cleaned;
