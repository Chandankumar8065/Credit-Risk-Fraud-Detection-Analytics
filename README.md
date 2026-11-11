# Credit Risk & Fraud Detection Analytics

An end-to-end data analytics portfolio project built using Python, SQL, and Power BI. The project explores customer profiles, loan applications, loan performance, repayment behaviour, and transaction-level fraud indicators across five synthetic banking datasets.

> **Dataset note:** All records are synthetic and are intended for learning and portfolio demonstration. They do not represent real customers, financial institutions, or actual fraud cases.

## Project scope

- **Python:** data loading, cleaning, validation, exploratory data analysis (EDA), and analytical summaries.
- **SQL:** database/table setup, post-import validation, and 50 business analysis queries.
- **Power BI:** dashboards for loan default, fraud detection, and loan repayment.
- **Dataset scale:** 1,250,000 records across five CSV datasets.

## Dashboards

The three report names are documented in [PowerBI](PowerBI/README.md). Screenshot PNGs and PBIX binaries are still pending upload to this repository; the preview folder currently contains an upload note, not the image files.

A Customer Churn screenshot was also supplied during the project handoff. It belongs to a separate project and is not presented as a Credit Risk dashboard.

## Dataset inventory

| Dataset | Rows |
|---|---:|
| Customers | 87,719 |
| Loan applications | 131,579 |
| Loan accounts | 65,789 |
| Transactions | 438,601 |
| Loan repayments | 526,312 |
| **Total** | **1,250,000** |

See [data_dictionary.json](datasets/original/data_dictionary.json) for field definitions.

## Selected findings

The following are project analysis results previously calculated from the synthetic data:

- Loan accounts: **65,789**
- Defaults: **3,295**
- Overall default rate: **about 5.01%**
- Transactions: **438,601**
- Fraud-flagged transactions: **3,360** (**about 0.77%**)
- Loan repayments: **526,312**
- Net scheduled-versus-paid installment shortfall: **978,667,569.61** (dataset currency units)

The repayment shortfall is an installment-level difference, not a verified outstanding-principal balance. Fraud reason labels and default flags are synthetic indicators, not evidence of real-world causes.

## Repository structure

```text
Credit-Risk-Fraud-Detection-Analytics/
├── README.md
├── datasets/
│   └── original/
├── Python/
├── SQL/
├── PowerBI/
├── Dashboard_Previews/
└── Documentation/
```

## How to explore

1. Start with the data dictionary and dataset README.
2. Review the Python notebook for data checks and EDA.
3. Review the SQL scripts for database setup, validation, and business questions.
4. Review the Power BI report inventory in [PowerBI/README.md](PowerBI/README.md).
5. When the PBIX binaries are added, open them in Power BI Desktop to interact with the reports.

## Reproducibility and limitations

- The datasets are large; use sufficient memory or the supplied summary outputs for lightweight dashboard work.
- The SQL scripts are prepared for import and analysis. Unless execution evidence is included, they should be treated as prepared scripts, not proof that every query was run against a live database.
- Some repayment fields are synthetic. In particular, payment status and late-payment indicators cannot be independently audited without a reliable actual payment-date field.
- Avoid using post-origination repayment outcomes as input features when building a model intended to predict default at application time; this would cause target leakage.

## Tools

Python · Pandas · NumPy · Matplotlib · Seaborn · SQL · Power BI

---
Created as a data analytics portfolio project.