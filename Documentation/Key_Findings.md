# Key Findings

The results below were calculated during the project's Python analysis of the synthetic banking datasets.

## Portfolio overview

- Customers: **87,719**
- Loan applications: **131,579**
- Loan accounts: **65,789**
- Transactions: **438,601**
- Repayment installments: **526,312**
- Total records: **1,250,000**

## Credit risk

- Defaulted loans: **3,295**
- Overall default rate: **5.01%**
- Total disbursed principal: approximately **₹49.42 billion** (₹4,941.78 crore).
- Education loans had the highest default rate among the loan types in the project analysis (approximately **5.40%**). Personal loans accounted for the largest number of defaults because they were the largest loan category by volume.

## Fraud indicators

- Fraud-flagged transactions: **3,360**
- Total transactions: **438,601**
- Fraud-flag rate: approximately **0.77%**
- Average transaction amount: approximately **₹2,565.30**.

## Repayment behaviour

- Paid or paid-late installments: **484,435**
- Overdue installments: **32,788**
- Missed installments: **9,089**
- Net scheduled-minus-paid installment difference: approximately **₹978.67 million**.

The last figure is the net installment-level scheduled-versus-paid difference. It is **not** a verified outstanding-principal balance or an official exposure measure.

## Interpretation and modelling cautions

1. The data, identities, events, outcomes, and labels are synthetic. Findings demonstrate analytical workflow rather than real banking or fraud patterns.
2. Fraud reason signals are illustrative fields, not verified causal explanations.
3. The transaction table is not a complete bank ledger and must not be used to infer account balances.
4. The repayment table has scheduled due dates but no actual payment-date field. Payment-status and lateness labels cannot be independently audited from payment dates.
5. Repayment behaviour occurs after loan origination. Using repayment outcomes to predict default at application time would introduce target leakage.
6. The default flag is simulated and should not be presented as evidence of real credit performance.
