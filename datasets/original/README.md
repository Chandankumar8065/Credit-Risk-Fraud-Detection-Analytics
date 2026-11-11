# Source Dataset — 1.25 Million Synthetic Records

## Dataset inventory

| File | Rows |
|---|---:|
| customers.csv | 87,719 |
| loan_applications.csv | 131,579 |
| loan_accounts.csv | 65,789 |
| transactions.csv | 438,601 |
| loan_repayments.csv | 526,312 |
| **Total** | **1,250,000** |

## Relationships

- customers.customer_id → loan_applications.customer_id
- customers.customer_id → loan_accounts.customer_id
- loan_applications.application_id → loan_accounts.application_id
- loan_accounts.loan_id → loan_repayments.loan_id
- customers.customer_id → transactions.customer_id

## Notes and limitations

All data, identities, amounts, dates, and outcome labels are synthetic. This dataset is for learning and portfolio analysis, not production banking, regulatory decisions, or validated risk/fraud modelling. Fraud and default labels are simulated. The transaction table is not a bank ledger and cannot be used to calculate account balances. No real personal identifiers are included.

Use chunked loading for large CSVs if RAM is limited. Suggested workflow: Python profiling/EDA, SQL relational analysis, and Power BI reporting.
