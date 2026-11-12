# Lightweight Power BI Guide

The project contains five synthetic source datasets totaling 1,250,000 records. Compact, pre-aggregated summaries are used to keep the four Power BI reports responsive on a low-memory laptop.

## Rebuild the summary data

The summary CSVs are generated locally and are not currently committed individually. To recreate the 11 summary tables used by the report model:

1. Ensure the five compressed source files are present in `datasets/cleaned/`.
2. Install the Python dependencies: `pandas` and `numpy`.
3. From the repository root, run:

   ```bash
   python Python/build_powerbi_summaries.py
   ```

4. The script writes the summary CSVs to `PowerBI/summary_data/`. In Power BI Desktop, use **Get data > Text/CSV** to load the relevant summary tables and update each report's source path as needed.

The script processes one source dataset at a time and uses only the columns needed for aggregation. This avoids loading all five 1.25-million-row tables into memory together.

## Page-to-summary mapping

- Page 1 — Credit Risk Overview: customer profile, loan type, risk segment, monthly loan and application summaries.
- Page 2 — Loan Default Analysis: loan type, loan risk segment, credit score and monthly loan summaries.
- Page 3 — Fraud Detection: channel/type/merchant, device/international, fraud reason and monthly fraud summaries.
- Page 4 — Repayment Performance: repayment status, risk and monthly repayment summaries.

See `summary_data/README.md` for the generated filenames and field definitions.

## Relationships and aggregation

The summary files are independent aggregated result tables. Do not create relationships between them unless a shared dimension table is deliberately added. Use each summary table's own fields for its visuals and slicers. This avoids accidental many-to-many relationships and double counting.

For ratios, calculate SUM(numerator) / SUM(denominator). For averages calculated from grouped averages, use weighted calculations (group average × group count, divided by total count). The measures in [DAX_Measures.txt](DAX_Measures.txt) follow these rules.

## Known limitations

- The source data is synthetic and intended for portfolio demonstration.
- Fraud reason signals are illustrative labels, not verified causal explanations.
- Transaction records are not a bank ledger; transaction values must not be described as account balances.
- Repayment records have no actual payment_date field. days_late and payment_status cannot be independently audited against a payment timestamp.
- Summary CSVs support aggregated dashboard visuals. They do not retain individual-level drill-through or arbitrary customer-level filtering.
- For full detail or reproducible row-level SQL, use the original cleaned CSVs and SQL package.

See [KPI_snapshot.json](KPI_snapshot.json) for key totals.
