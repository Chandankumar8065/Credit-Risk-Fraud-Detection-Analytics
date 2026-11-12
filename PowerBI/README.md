# Power BI Reports

This folder contains four Power BI Desktop reports, their dashboard previews, DAX measures, KPI snapshot and guidance for rebuilding the lightweight summary model.

## Report inventory

| Report | Power BI file | Preview |
|---|---|---|
| Credit Risk Overview | [Credit_risk_&_Fraud_Detection.pbix](Credit_risk_&_Fraud_Detection.pbix) | [View screenshot](../Dashboard_Previews/Credit_Risk_Overview.png) |
| Loan Default Analysis | [Loan_Default_Analysis.pbix](Loan_Default_Analysis.pbix) | [View screenshot](../Dashboard_Previews/Loan_Default_Analysis.png) |
| Fraud Detection Analysis | [Fraud_Detection_Analysis.pbix](Fraud_Detection_Analysis.pbix) | [View screenshot](../Dashboard_Previews/Fraud_Detection_Analysis.png) |
| Loan Repayment Analysis | [Loan_Repayment_Analysis.pbix](Loan_Repayment_Analysis.pbix) | [View screenshot](../Dashboard_Previews/Loan_Repayment_Analysis.png) |

See the [Dashboard Preview Gallery](../Dashboard_Previews/README.md) to view all four screenshots on one page.

## Supporting files

- [DAX_Measures.dax](DAX_Measures.dax) and [DAX_Measures.txt](DAX_Measures.txt) — copy-ready measure definitions, including weighted averages.
- [KPI_snapshot.json](KPI_snapshot.json) — selected project KPI values.
- [Lightweight_PowerBI_Guide.md](Lightweight_PowerBI_Guide.md) — model structure, limitations and rebuild instructions.
- [Summary data guide](summary_data/README.md) — summary table names and generation instructions.
- [Summary builder script](../Python/build_powerbi_summaries.py) — recreates the 11 aggregated CSV files from the cleaned source datasets.

## Rebuild the report data

The summary CSVs are generated locally and are not currently committed individually. From the repository root, run:

```bash
python Python/build_powerbi_summaries.py
```

Then load the generated files from `PowerBI/summary_data/` in Power BI Desktop and update the report data-source paths if required. The script processes one source dataset at a time to reduce memory pressure.

## Modelling approach

The source data contains 1.25 million records. Aggregated summary tables are used to keep Power BI responsive on a low-memory laptop. This supports portfolio-level trends and KPIs, but it does not preserve unrestricted row-level drill-through.

For ratios, divide aggregated numerators by aggregated denominators. For averages over grouped averages, use weighted calculations based on each group's count. The supplied DAX measures follow these rules.

## Interpretation notes

All records and labels are synthetic. Fraud reason fields are illustrative, transaction totals are not bank account balances, and the repayment shortfall is not a verified outstanding-principal balance. See the [Key Findings](../Documentation/Key_Findings.md) and [Data Validation Report](../Documentation/Data_Validation.md).
