# SQL Analysis

**SQL dialect:** MySQL 8.0

This folder contains the database schema, post-import validation checks, and 50 business analysis queries.

## Files and execution order

1. [01_Database_and_Tables.sql](01_Database_and_Tables.sql) — create the database and five InnoDB tables.
2. Import the five cleaned datasets into the matching tables (see mapping below).
3. [02_Post_Import_Validation.sql](02_Post_Import_Validation.sql) — check row counts, primary keys, and foreign-key references after import.
4. [03_50_Business_Analysis_Queries.sql](03_50_Business_Analysis_Queries.sql) — run the 50 numbered business analysis queries.

## Dataset-to-table mapping

| Compressed dataset | Target table |
|---|---|
| customers_cleaned.csv.gz | customers |
| applications_cleaned.csv.gz | applications |
| loans_cleaned.csv.gz | loans |
| transactions_cleaned.csv.gz | transactions |
| repayments_cleaned.csv.gz | repayments |

The files are in [datasets/cleaned](../datasets/cleaned/). Extract the gzip files before using a CSV import workflow that does not support compressed input.

## Import order

1. customers
2. applications
3. loans
4. transactions
5. repayments

This order respects the foreign-key dependencies.

## Notes and limitations

All records and labels are synthetic. The fraud reason field is illustrative, not a confirmed explanation. The transaction table is not a complete bank ledger. The repayment data does not contain a reliable actual payment-date field, so payment status and lateness indicators cannot be independently audited from payment timestamps.

The validation script is intended to be run after import. The documented validation counts are from the recorded Python checks; rerun the SQL checks in your own MySQL instance to verify the imported tables. Do not treat the presence of SQL scripts in the repository as proof that they have been executed in a live database.
