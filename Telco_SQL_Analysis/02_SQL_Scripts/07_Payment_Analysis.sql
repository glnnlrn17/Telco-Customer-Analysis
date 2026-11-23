-- 07 Payment analysis

-- payment_summary
SELECT payment_method,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct,
       ROUND(AVG(monthly_charges), 2) AS avg_monthly_charge
FROM customers_clean GROUP BY payment_method ORDER BY churn_rate_pct DESC;

-- payment_by_contract
SELECT contract, payment_method, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY contract, payment_method ORDER BY contract, churn_rate_pct DESC;

-- electronic_check_share
SELECT ROUND(100.0 * SUM(CASE WHEN payment_method = 'Electronic check' THEN 1 ELSE 0 END) / COUNT(*), 2) AS electronic_check_share_pct,
       ROUND(100.0 * SUM(CASE WHEN payment_method = 'Electronic check' AND churn_flag = 1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(churn_flag), 0), 2) AS share_of_churners_pct
FROM customers_clean;
