# Generated Power BI Summary Tables

Run `python Python/build_powerbi_summaries.py` from the repository root to generate the 11 CSVs used by the lightweight Power BI model.

The source files are read from `datasets/cleaned/`. The script writes its outputs here and never overwrites the source datasets.

| Output CSV | Grain / grouping |
|---|---|
| `01_customer_profile_summary.csv` | Customer risk segment |
| `02_loan_type_summary.csv` | Loan type |
| `03_loan_risk_segment_summary.csv` | Customer risk segment for issued loans |
| `04_monthly_loan_summary.csv` | Disbursement month |
| `05_loan_status_summary.csv` | Loan account status |
| `06_application_summary.csv` | Application decision and loan type |
| `07_fraud_channel_type_merchant.csv` | Channel, transaction type and merchant category |
| `08_fraud_device_international.csv` | New-device and international indicators |
| `09_fraud_reason_summary.csv` | Illustrative fraud reason signal |
| `10_monthly_fraud_summary.csv` | Transaction month |
| `11_repayment_status_summary.csv` | Repayment payment status |

These are aggregate tables, not row-level data. They support summary visuals but do not enable unrestricted customer- or transaction-level drill-through. The underlying records are synthetic.
