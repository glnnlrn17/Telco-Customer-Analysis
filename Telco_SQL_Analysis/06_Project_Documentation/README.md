# Telco Customer Churn: SQL Portfolio Project

Analysis of 7,043 telecom customers (21 raw fields) to find out why customers leave and which groups are most at risk.

## Folder guide
- **01_Dataset**: raw CSV and data dictionary (raw and cleaned fields).
- **02_SQL_Scripts**: nine SQLite scripts, run in order: data quality checks, cleaning, overview, churn, revenue, services, payment, tenure, business insights.
- **03_Cleaned_Data**: `customers_clean.csv` (7,043 rows, 27 columns) and the cleaning log.
- **04_Analysis_Results**: one Excel workbook per analysis area.
- **05_Dashboard**: Excel dashboard with dropdown filters (contract, internet service, payment method, gender), a PDF export and a screenshot. The Looker Studio link is not published (see `Dashboard_Link.txt`).
- **06_Project_Documentation**: this README, the final report (PDF) and business recommendations (Word).

## Headline results
- Churn is 26.5% (1,869 of 7,043). Lost monthly revenue is $139,131, 30.5% of the $456,117 total.
- Month-to-month contracts churn at 42.7%, against 11.3% (one year) and 2.8% (two year).
- Fiber optic customers churn at 41.9%. Electronic check payers churn at 45.3%.
- First-year customers churn at 47.4%. Customers past 24 months churn at 14.0%.
- Customers without tech support churn at 41.6%, against 15.2% with it.

## Data notes
- `TotalCharges` has 11 blank values (new customers with zero tenure). They were set to 0 and flagged.
- `service_count` counts the eight optional services and ranges from 1 to 8 in this data.
- The dataset has no city or year fields, so the dashboard filters are the four listed above.
- These are associations in one snapshot, not proof that any offer would reduce churn.
