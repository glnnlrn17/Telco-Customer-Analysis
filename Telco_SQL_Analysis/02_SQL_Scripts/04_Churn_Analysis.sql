-- 04 Churn analysis (table: customers_clean)

-- @name churn_by_tenure_band
SELECT tenure_band,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY tenure_band
ORDER BY MIN(tenure);

-- @name churn_by_contract_and_internet
SELECT contract, internet_service,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY contract, internet_service
ORDER BY contract, internet_service;

-- @name churn_by_charge_band
SELECT charge_band,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY charge_band
ORDER BY MIN(monthly_charges);

-- @name churn_by_service_count
SELECT service_count,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY service_count
ORDER BY service_count;

-- @name churn_by_paperless
SELECT paperless_billing,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY paperless_billing ORDER BY churn_rate_pct DESC;
