# SQL Package

**Dialect:** MySQL 8.0.

## Files
- `01_Database_and_Tables.sql`: creates the database and five InnoDB tables.
- `02_Post_Import_Validation.sql`: validates imported row counts, primary keys, and foreign-key references.
- `03_50_Business_Analysis_Queries.sql`: 50 numbered business-analysis queries.

## Source CSV mapping
- `customers.csv` → `customers`
- `loan_applications.csv` → `applications`
- `loan_accounts.csv` → `loans`
- `transactions.csv` → `transactions`
- `loan_repayments.csv` → `repayments`

## Import order
1. customers
2. applications
3. loans
4. transactions
5. repayments

The order respects the foreign-key dependencies.

## Important limitations
All records and labels are synthetic. Results are for learning and portfolio analysis, not real-world credit decisions or validated fraud prediction. The fraud reason field is illustrative, not a confirmed explanation. Do not interpret transaction sums as bank account balances. The repayment source does not contain an actual payment-date field, so status/late indicators cannot be independently audited from dates.