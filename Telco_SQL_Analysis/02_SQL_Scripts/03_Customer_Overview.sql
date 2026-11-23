-- 03 Customer overview (table: customers_clean)

-- @name overall_kpis
SELECT COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct,
       ROUND(AVG(tenure), 1) AS avg_tenure_months,
       ROUND(SUM(monthly_charges), 0) AS monthly_recurring_revenue,
       ROUND(AVG(monthly_charges), 2) AS avg_monthly_charge
FROM customers_clean;

-- @name customers_by_contract
SELECT contract,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM customers_clean), 2) AS share_of_customers_pct
FROM customers_clean GROUP BY contract ORDER BY churn_rate_pct DESC;

-- @name customers_by_internet
SELECT internet_service,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY internet_service ORDER BY churn_rate_pct DESC;

-- @name customers_by_payment
SELECT payment_method,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY payment_method ORDER BY churn_rate_pct DESC;

-- @name demographics
SELECT 'Gender' AS dimension, gender AS value, COUNT(*) AS customers, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct FROM customers_clean GROUP BY gender
UNION ALL SELECT 'Senior citizen', senior_citizen, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) FROM customers_clean GROUP BY senior_citizen
UNION ALL SELECT 'Partner', partner, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) FROM customers_clean GROUP BY partner
UNION ALL SELECT 'Dependents', dependents, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) FROM customers_clean GROUP BY dependents;
