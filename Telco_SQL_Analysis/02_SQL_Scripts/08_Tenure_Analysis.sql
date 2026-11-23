-- 08 Tenure analysis 

-- churn_by_tenure_month
SELECT tenure AS tenure_month,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY tenure ORDER BY tenure;

-- survival_milestones
SELECT
  ROUND(100.0 * SUM(CASE WHEN tenure <= 12 AND churn_flag = 1 THEN 1 ELSE 0 END) / SUM(CASE WHEN tenure <= 12 THEN 1 ELSE 0 END), 2) AS churn_first_12_months_pct,
  ROUND(100.0 * SUM(CASE WHEN tenure > 24 AND churn_flag = 1 THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN tenure > 24 THEN 1 ELSE 0 END), 0), 2) AS churn_after_24_months_pct
FROM customers_clean;

-- avg_tenure_churned_vs_retained
SELECT churn, ROUND(AVG(tenure), 1) AS avg_tenure, COUNT(*) AS customers FROM customers_clean GROUP BY churn;
