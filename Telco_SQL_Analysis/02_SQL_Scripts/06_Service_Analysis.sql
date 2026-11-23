-- 06 Service analysis

-- churn_by_tech_support
SELECT tech_support AS value, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY tech_support ORDER BY churn_rate_pct DESC;

-- churn_by_online_security
SELECT online_security AS value, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY online_security ORDER BY churn_rate_pct DESC;

-- churn_by_streaming
SELECT 'StreamingTV' AS service, streaming_tv AS value, COUNT(*) AS customers, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct FROM customers_clean GROUP BY streaming_tv
UNION ALL SELECT 'StreamingMovies', streaming_movies, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) FROM customers_clean GROUP BY streaming_movies;

-- churn_by_phone_lines
SELECT phone_service, multiple_lines, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean GROUP BY phone_service, multiple_lines ORDER BY churn_rate_pct DESC;
