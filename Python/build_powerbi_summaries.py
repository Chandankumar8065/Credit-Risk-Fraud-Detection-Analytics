"""Build the compact CSV summary tables used by the four Power BI reports.

Run from the repository root:
    python Python/build_powerbi_summaries.py

The script reads the committed GZIP CSVs one dataset at a time and writes
aggregated outputs to PowerBI/summary_data/. It does not modify source files.
"""
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "datasets" / "cleaned"
OUTPUT = ROOT / "PowerBI" / "summary_data"
OUTPUT.mkdir(parents=True, exist_ok=True)

FILES = {
    "customers": "customers_cleaned.csv.gz",
    "applications": "applications_cleaned.csv.gz",
    "loans": "loans_cleaned.csv.gz",
    "transactions": "transactions_cleaned.csv.gz",
    "repayments": "repayments_cleaned.csv.gz",
}


def load(name, columns):
    path = SOURCE / FILES[name]
    if not path.exists():
        raise FileNotFoundError(
            f"Missing {path}. Restore the committed cleaned datasets before running."
        )
    return pd.read_csv(path, compression="gzip", usecols=columns)


def save(name, frame):
    path = OUTPUT / f"{name}.csv"
    frame.to_csv(path, index=False)
    print(f"Created {path.relative_to(ROOT)} — {len(frame):,} summary rows")


# 01 — Customer profile by risk segment
customers = load("customers", ["customer_id", "age", "annual_income_inr", "risk_segment"])
customer_profile = customers.groupby("risk_segment", dropna=False).agg(
    customers=("customer_id", "nunique"),
    avg_age=("age", "mean"),
    avg_annual_income_inr=("annual_income_inr", "mean"),
).reset_index()
save("01_customer_profile_summary", customer_profile)
del customer_profile, customers

# 02 — Loan type summary
loans = load("loans", [
    "loan_id", "customer_id", "loan_type", "disbursement_date",
    "principal_amount_inr", "annual_interest_rate_pct",
    "credit_score_at_origination", "default_flag", "account_status"
])
loan_type = loans.groupby("loan_type", dropna=False).agg(
    total_loans=("loan_id", "nunique"),
    defaults=("default_flag", "sum"),
    total_principal_inr=("principal_amount_inr", "sum"),
    avg_interest_rate_pct=("annual_interest_rate_pct", "mean"),
).reset_index()
save("02_loan_type_summary", loan_type)

# 03 — Loan risk segment summary
customer_segments = load("customers", ["customer_id", "risk_segment"])
loan_risk = loans.merge(customer_segments, on="customer_id", how="left")
risk_summary = loan_risk.groupby("risk_segment", dropna=False).agg(
    total_loans=("loan_id", "nunique"),
    defaults=("default_flag", "sum"),
    total_principal_inr=("principal_amount_inr", "sum"),
    avg_credit_score=("credit_score_at_origination", "mean"),
).reset_index()
save("03_loan_risk_segment_summary", risk_summary)
del loan_risk, risk_summary, customer_segments

# 04 — Monthly loan summary
loans["month"] = pd.to_datetime(loans["disbursement_date"], errors="coerce").dt.to_period("M").astype("string")
monthly_loans = loans.groupby("month", dropna=False).agg(
    total_loans=("loan_id", "nunique"),
    defaults=("default_flag", "sum"),
    total_principal_inr=("principal_amount_inr", "sum"),
).reset_index()
save("04_monthly_loan_summary", monthly_loans)
del monthly_loans, loans

# 05 — Loan account status summary
loans_status = load("loans", ["loan_id", "account_status", "principal_amount_inr", "default_flag"])
status_summary = loans_status.groupby("account_status", dropna=False).agg(
    total_loans=("loan_id", "nunique"),
    defaults=("default_flag", "sum"),
    total_principal_inr=("principal_amount_inr", "sum"),
).reset_index()
save("05_loan_status_summary", status_summary)
del status_summary, loans_status

# 06 — Application summary by decision and loan type
applications = load("applications", [
    "application_id", "decision", "loan_type", "requested_amount_inr"
])
application_summary = applications.groupby(["decision", "loan_type"], dropna=False).agg(
    applications=("application_id", "nunique"),
    avg_requested_amount_inr=("requested_amount_inr", "mean"),
    total_requested_amount_inr=("requested_amount_inr", "sum"),
).reset_index()
save("06_application_summary", application_summary)
del application_summary, applications

# 07 — Fraud summary by channel, transaction type and merchant category
transactions = load("transactions", [
    "transaction_id", "transaction_timestamp", "transaction_type",
    "channel", "merchant_category", "amount_inr", "fraud_flag",
    "device_new_flag", "international_flag", "fraud_reason_signal"
])
fraud_channel = transactions.groupby(
    ["channel", "transaction_type", "merchant_category"], dropna=False
).agg(
    transactions=("transaction_id", "nunique"),
    fraud_transactions=("fraud_flag", "sum"),
    transaction_value_inr=("amount_inr", "sum"),
).reset_index()
save("07_fraud_channel_type_merchant", fraud_channel)

# 08 — Fraud summary by device and international indicators
fraud_device = transactions.groupby(
    ["device_new_flag", "international_flag"], dropna=False
).agg(
    transactions=("transaction_id", "nunique"),
    fraud_transactions=("fraud_flag", "sum"),
    transaction_value_inr=("amount_inr", "sum"),
).reset_index()
save("08_fraud_device_international", fraud_device)

# 09 — Fraud reason signal summary
fraud_reason = transactions.groupby("fraud_reason_signal", dropna=False).agg(
    transactions=("transaction_id", "nunique"),
    fraud_transactions=("fraud_flag", "sum"),
    transaction_value_inr=("amount_inr", "sum"),
).reset_index()
save("09_fraud_reason_summary", fraud_reason)

# 10 — Monthly fraud summary
transactions["month"] = pd.to_datetime(
    transactions["transaction_timestamp"], errors="coerce"
).dt.to_period("M").astype("string")
monthly_fraud = transactions.groupby("month", dropna=False).agg(
    transactions=("transaction_id", "nunique"),
    fraud_transactions=("fraud_flag", "sum"),
    transaction_value_inr=("amount_inr", "sum"),
).reset_index()
save("10_monthly_fraud_summary", monthly_fraud)
del monthly_fraud, fraud_reason, fraud_device, fraud_channel, transactions

# 11 — Repayment summary by payment status
repayments = load("repayments", [
    "repayment_id", "payment_status", "scheduled_amount_inr",
    "paid_amount_inr", "days_late"
])
repayment_status = repayments.groupby("payment_status", dropna=False).agg(
    installments=("repayment_id", "nunique"),
    scheduled_amount_inr=("scheduled_amount_inr", "sum"),
    paid_amount_inr=("paid_amount_inr", "sum"),
    avg_days_late=("days_late", "mean"),
).reset_index()
save("11_repayment_status_summary", repayment_status)
del repayment_status, repayments

print("\nAll 11 Power BI summary tables were generated successfully.")
print("Output folder:", OUTPUT)
