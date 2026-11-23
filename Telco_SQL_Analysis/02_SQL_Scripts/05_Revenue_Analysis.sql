-- 05 Revenue analysis

-- revenue_by_contract
SELECT contract,
       ROUND(SUM(monthly_charges), 0) AS monthly_revenue,
       ROUND(SUM(CASE WHEN churn_flag = 1 THEN monthly_charges ELSE 0 END), 0) AS monthly_revenue_lost,
       ROUND(100.0 * SUM(CASE WHEN churn_flag = 1 THEN monthly_charges ELSE 0 END) / SUM(monthly_charges), 2) AS revenue_lost_pct
FROM customers_clean GROUP BY contract ORDER BY monthly_revenue DESC;

-- charges_churned_vs_retained
SELECT churn,
       COUNT(*) AS customers,
       ROUND(AVG(monthly_charges), 2) AS avg_monthly_charge,
       ROUND(AVG(tenure), 1) AS avg_tenure
FROM customers_clean GROUP BY churn;

-- lifetime_value_proxy
SELECT churn,
       ROUND(AVG(total_charges), 0) AS avg_total_charges
FROM customers_clean WHERE total_charges_blank_flag = 0 GROUP BY churn;

-- monthly_revenue_at_risk
SELECT ROUND(SUM(CASE WHEN churn_flag = 1 THEN monthly_charges ELSE 0 END), 0) AS monthly_revenue_lost,
       ROUND(SUM(monthly_charges), 0) AS monthly_revenue_total
FROM customers_clean;
