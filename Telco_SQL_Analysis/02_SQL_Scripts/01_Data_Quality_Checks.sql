-- 01 Data quality checks on the raw Telco table (telco_raw). All text as loaded.

-- @name row_count
SELECT COUNT(*) AS total_rows FROM telco_raw;

-- @name duplicate_customer_ids
SELECT COUNT(*) AS duplicate_customer_ids
FROM (SELECT customerID FROM telco_raw GROUP BY customerID HAVING COUNT(*) > 1);

-- @name missing_values
SELECT
  SUM(customerID IS NULL OR TRIM(customerID) = '')   AS missing_customer_id,
  SUM(tenure IS NULL OR TRIM(tenure) = '')           AS missing_tenure,
  SUM(MonthlyCharges IS NULL OR TRIM(MonthlyCharges) = '') AS missing_monthly_charges,
  SUM(Churn IS NULL OR TRIM(Churn) = '')             AS missing_churn,
  SUM(Contract IS NULL OR TRIM(Contract) = '')       AS missing_contract
FROM telco_raw;

-- @name blank_total_charges
-- TotalCharges is stored as text. Blank values are customers with tenure 0 (no bill yet).
SELECT COUNT(*) AS blank_total_charges,
       SUM(CASE WHEN CAST(tenure AS INTEGER) = 0 THEN 1 ELSE 0 END) AS of_which_tenure_zero
FROM telco_raw
WHERE TRIM(TotalCharges) = '';

-- @name invalid_values
SELECT
  SUM(CAST(tenure AS INTEGER) < 0)                 AS negative_tenure,
  SUM(CAST(MonthlyCharges AS REAL) <= 0)           AS non_positive_monthly_charges,
  SUM(Churn NOT IN ('Yes','No'))                   AS churn_not_yes_no,
  SUM(SeniorCitizen NOT IN ('0','1'))              AS senior_not_0_1
FROM telco_raw;

-- @name distinct_values_check
SELECT 'Contract' AS field, COUNT(DISTINCT Contract) AS distinct_values FROM telco_raw
UNION ALL SELECT 'InternetService', COUNT(DISTINCT InternetService) FROM telco_raw
UNION ALL SELECT 'PaymentMethod', COUNT(DISTINCT PaymentMethod) FROM telco_raw
UNION ALL SELECT 'gender', COUNT(DISTINCT gender) FROM telco_raw
UNION ALL SELECT 'Churn', COUNT(DISTINCT Churn) FROM telco_raw;
