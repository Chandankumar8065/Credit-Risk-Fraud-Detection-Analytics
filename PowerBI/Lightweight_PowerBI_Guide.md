# Lightweight Power BI Starter

The source project contains five synthetic datasets totaling 1,250,000 rows. Compact pre-aggregated CSV summaries were prepared to reduce memory pressure on a low-memory laptop. The summary ZIP package is available separately in the working files; the summary CSVs are not yet individually committed here.

## Suggested page-to-file mapping

- Page 1 — Credit Risk Overview: customer profile, loan type, loan risk segment, monthly loan, and application summaries.
- Page 2 — Loan Default Analysis: loan type, loan risk segment, credit score, and monthly loan summaries.
- Page 3 — Fraud Detection: channel/type/merchant, device/international, fraud reason, and monthly fraud summaries.
- Page 4 — Repayment Performance: repayment status, risk, and monthly repayment summaries.

## Relationships

The summary files are independent aggregated result tables. Do not create relationships between them unless a shared dimension table is deliberately added. Use each summary table's own fields for its visuals and slicers. This avoids accidental many-to-many relationships and double counting.

## Important measure guidance

Use [DAX_Measures.txt](DAX_Measures.txt). For ratios, calculate SUM(numerator) / SUM(denominator); do not average precomputed rates. Some summary tables contain averages by group; those descriptive values should not be summed.

## Known limitations

- The source data is synthetic and intended for learning/portfolio demonstration.
- Fraud reason signals are illustrative labels, not verified causal explanations.
- Transaction records are not a bank ledger; transaction values must not be described as account balances.
- Repayment records have no actual payment_date field. days_late and payment_status cannot be independently audited against a payment timestamp.
- Summary CSVs support aggregated dashboard visuals. They do not retain individual-level drill-through or arbitrary customer-level filtering.
- For full detail or reproducible row-level SQL, retain the original CSV archive and SQL package separately.

See [KPI_snapshot.json](KPI_snapshot.json) for key totals.
