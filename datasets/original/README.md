# Dataset Source Notes and Data Dictionary

The project uses five related synthetic banking datasets containing **1,250,000 records** in total. This folder documents the source dataset structure and relationships. The cleaned, compressed CSV files are stored separately in [datasets/cleaned](../cleaned/).

## Dataset inventory

| Dataset | Rows | Columns |
|---|---:|---:|
| Customers | 87,719 | 9 |
| Loan applications | 131,579 | 11 |
| Loan accounts | 65,789 | 12 |
| Transactions | 438,601 | 13 |
| Loan repayments | 526,312 | 9 |
| **Total** | **1,250,000** | — |

See [data_dictionary.json](data_dictionary.json) for field definitions.

## Relationships

- customers.customer_id → loan_applications.customer_id
- customers.customer_id → loan_accounts.customer_id
- loan_applications.application_id → loan_accounts.application_id
- loan_accounts.loan_id → loan_repayments.loan_id
- customers.customer_id → transactions.customer_id

## Data disclaimer

All records, identities, amounts, dates, and outcome labels are synthetic. They are for learning and portfolio analysis, not production banking, regulatory decisions, or validated risk/fraud modelling. Fraud and default labels are simulated. The transaction table is not a complete bank ledger and cannot be used to calculate account balances.
