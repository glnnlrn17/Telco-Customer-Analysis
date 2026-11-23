-- 09 Business insights

-- insight_headline
SELECT ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct, SUM(churn_flag) AS churned, COUNT(*) AS customers FROM customers_clean;

-- insight_contract_gap
SELECT contract, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct FROM customers_clean GROUP BY contract ORDER BY churn_rate_pct DESC;

-- insight_internet_gap
SELECT internet_service, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct FROM customers_clean GROUP BY internet_service ORDER BY churn_rate_pct DESC;

-- insight_payment_gap
SELECT payment_method, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct FROM customers_clean GROUP BY payment_method ORDER BY churn_rate_pct DESC;

-- insight_tech_support_gap
SELECT tech_support, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct FROM customers_clean GROUP BY tech_support ORDER BY churn_rate_pct DESC;

-- insight_first_year_churn
SELECT ROUND(100.0 * SUM(CASE WHEN tenure <= 12 AND churn_flag = 1 THEN 1 ELSE 0 END) / SUM(CASE WHEN tenure <= 12 THEN 1 ELSE 0 END), 1) AS first_year_churn_pct,
       ROUND(100.0 * SUM(CASE WHEN tenure <= 12 AND churn_flag = 1 THEN 1 ELSE 0 END) / SUM(churn_flag), 1) AS share_of_churners_in_first_year_pct
FROM customers_clean;

-- insight_revenue_lost
SELECT ROUND(SUM(CASE WHEN churn_flag = 1 THEN monthly_charges ELSE 0 END), 0) AS monthly_revenue_lost,
       ROUND(100.0 * SUM(CASE WHEN churn_flag = 1 THEN monthly_charges ELSE 0 END) / SUM(monthly_charges), 1) AS revenue_lost_pct
FROM customers_clean;
