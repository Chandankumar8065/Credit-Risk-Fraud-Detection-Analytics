# Data Validation Report

The five cleaned synthetic datasets were checked before the repository documentation was prepared.

## Dataset-level checks

| Dataset | Rows | Columns | Null cells | Duplicate rows | Duplicate primary keys |
|---|---:|---:|---:|---:|---:|
| customers | 87,719 | 9 | 0 | 0 | 0 |
| loan_applications | 131,579 | 11 | 0 | 0 | 0 |
| loan_accounts | 65,789 | 12 | 0 | 0 | 0 |
| transactions | 438,601 | 13 | 0 | 0 | 0 |
| loan_repayments | 526,312 | 10 | 0 | 0 | 0 |
| **Total** | **1,250,000** | — | **0** | **0** | **0** |

## Referential-integrity checks

| Relationship checked | Orphan records |
|---|---:|
| Applications → Customers | 0 |
| Loans → Applications | 0 |
| Loans → Customers | 0 |
| Transactions → Customers | 0 |
| Repayments → Loans | 0 |
| Repayments → Customers | 0 |

All six relationships returned zero missing parent references in the recorded validation run.

## Scope and reproducibility

The recorded checks cover row counts, null cells, full-row duplicates, primary-key uniqueness, and the six listed foreign-key relationships. The repository includes [SQL post-import validation queries](../SQL/02_Post_Import_Validation.sql) so these checks can be rerun after importing the data into MySQL.

These results document the recorded analysis; they are not evidence that the SQL scripts have been executed against every user's local database. They also do not independently validate every business rule or establish that synthetic labels represent real-world behaviour.
