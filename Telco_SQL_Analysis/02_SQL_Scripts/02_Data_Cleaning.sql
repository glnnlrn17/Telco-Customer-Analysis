-- 02 Data cleaning: builds customers_clean from telco_raw.
-- Decisions (see Cleaning_Log.xlsx):
--   * TotalCharges converted to a number. The 11 blank values belong to tenure-0 customers, set to 0 and flagged.
--   * SeniorCitizen 0/1 turned into No/Yes for readable charts.
--   * customerID kept as the key. No personal names exist in this dataset.
--   * Derived: churn_flag (1/0), tenure_band, has_internet, service_count, charge_band.

DROP TABLE IF EXISTS customers_clean;

CREATE TABLE customers_clean AS
SELECT
  customerID                                      AS customer_id,
  gender,
  CASE WHEN SeniorCitizen = '1' THEN 'Yes' ELSE 'No' END AS senior_citizen,
  Partner                                          AS partner,
  Dependents                                       AS dependents,
  CAST(tenure AS INTEGER)                          AS tenure,
  CASE
    WHEN CAST(tenure AS INTEGER) <= 12 THEN '0-12 months'
    WHEN CAST(tenure AS INTEGER) <= 24 THEN '13-24 months'
    WHEN CAST(tenure AS INTEGER) <= 48 THEN '25-48 months'
    ELSE '49-72 months'
  END                                              AS tenure_band,
  PhoneService                                     AS phone_service,
  MultipleLines                                    AS multiple_lines,
  InternetService                                  AS internet_service,
  CASE WHEN InternetService = 'No' THEN 'No' ELSE 'Yes' END AS has_internet,
  OnlineSecurity                                   AS online_security,
  OnlineBackup                                     AS online_backup,
  DeviceProtection                                 AS device_protection,
  TechSupport                                      AS tech_support,
  StreamingTV                                      AS streaming_tv,
  StreamingMovies                                  AS streaming_movies,
  Contract                                         AS contract,
  PaperlessBilling                                 AS paperless_billing,
  PaymentMethod                                    AS payment_method,
  CAST(MonthlyCharges AS REAL)                     AS monthly_charges,
  CASE WHEN TRIM(TotalCharges) = '' THEN 0 ELSE CAST(TotalCharges AS REAL) END AS total_charges,
  CASE WHEN TRIM(TotalCharges) = '' THEN 1 ELSE 0 END AS total_charges_blank_flag,
  Churn                                            AS churn,
  CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END        AS churn_flag,
  CASE
    WHEN MonthlyCharges < 35 THEN 'Under 35'
    WHEN MonthlyCharges < 70 THEN '35-69'
    WHEN MonthlyCharges < 90 THEN '70-89'
    ELSE '90+'
  END                                              AS charge_band,
  (CASE WHEN PhoneService = 'Yes' THEN 1 ELSE 0 END)
  + (CASE WHEN InternetService <> 'No' THEN 1 ELSE 0 END)
  + (CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END)
  + (CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END)
  + (CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END)
  + (CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END)
  + (CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END)
  + (CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END) AS service_count
FROM telco_raw;

-- @name clean_row_count
SELECT COUNT(*) AS clean_rows, SUM(churn_flag) AS churned, SUM(total_charges_blank_flag) AS blank_total_charges_set_to_zero FROM customers_clean;

-- @name tenure_range_check
SELECT MIN(tenure) AS min_tenure, MAX(tenure) AS max_tenure, MIN(monthly_charges) AS min_monthly, MAX(monthly_charges) AS max_monthly FROM customers_clean;
