# Power BI Reports

This folder contains four Power BI Desktop reports, the DAX measure reference, a KPI snapshot, and a guide to the lightweight summary model.

## Report inventory

| Report | Power BI file | Preview |
|---|---|---|
| Credit Risk Overview | [Credit_risk_&_Fraud_Detection.pbix](Credit_risk_&_Fraud_Detection.pbix) | [View screenshot](../Dashboard_Previews/Credit_Risk_Overview.png) |
| Loan Default Analysis | [Loan_Default_Analysis.pbix](Loan_Default_Analysis.pbix) | [View screenshot](../Dashboard_Previews/Loan_Default_Analysis.png) |
| Fraud Detection Analysis | [Fraud_Detection_Analysis.pbix](Fraud_Detection_Analysis.pbix) | [View screenshot](../Dashboard_Previews/Fraud_Detection_Analysis.png) |
| Loan Repayment Analysis | [Loan_Repayment_Analysis.pbix](Loan_Repayment_Analysis.pbix) | [View screenshot](../Dashboard_Previews/Loan_Repayment_Analysis.png) |

See the [Dashboard Preview Gallery](../Dashboard_Previews/README.md) to view all four screenshots on one page.

## Supporting files

- [DAX_Measures.dax](DAX_Measures.dax) — copy-ready measure definitions.
- [DAX_Measures.txt](DAX_Measures.txt) — readable DAX reference.
- [KPI_snapshot.json](KPI_snapshot.json) — selected project KPI values.
- [Lightweight_PowerBI_Guide.md](Lightweight_PowerBI_Guide.md) — report structure, modelling guidance, and limitations.

## Modelling approach

The source data contains 1.25 million records. Aggregated summary tables were used to keep Power BI responsive on a low-memory laptop. This supports portfolio-level trends and KPIs, but it does not preserve unrestricted row-level drill-through.

When calculating ratios, divide aggregated numerators by aggregated denominators (for example, total defaults divided by total loans). Avoid averaging pre-calculated group rates unless a weighted calculation is intended.

## Interpretation notes

All records and labels are synthetic. Fraud reason fields are illustrative, transaction totals are not bank account balances, and the repayment shortfall is not a verified outstanding-principal balance. See the [Key Findings](../Documentation/Key_Findings.md) and [Data Validation Report](../Documentation/Data_Validation.md).
