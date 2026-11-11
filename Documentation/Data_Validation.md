# Data Validation Report

The uploaded 1.25-million-record dataset archive was rechecked before preparing this repository documentation.

## Dataset-level checks

| Dataset | Rows | Columns | Null cells | Duplicate rows | Duplicate primary keys |
|---|---:|---:|---:|---:|---:|
| customers | 87,719 | 9 | 0 | 0 | 0 |
| loan_applications | 131,579 | 11 | 0 | 0 | 0 |
| loan_accounts | 65,789 | 12 | 0 | 0 | 0 |
| transactions | 438,601 | 13 | 0 | 0 | 0 |
| loan_repayments | 526,312 | 9 | 0 | 0 | 0 |
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

All six relationships returned zero missing parent references.

## Scope of validation

These checks cover row counts, null cells, full-row duplicates, primary-key uniqueness, and the six listed foreign-key relationships in the supplied ZIP. They do not establish that synthetic labels represent real-world behaviour or independently validate every business rule. See [Key Findings](Key_Findings.md) for analytical caveats.
