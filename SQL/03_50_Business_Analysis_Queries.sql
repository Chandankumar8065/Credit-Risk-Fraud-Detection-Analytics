-- 50 business-analysis queries | MySQL 8.0
-- Run after importing the five source CSV files.
USE CreditRiskFraudDB;


-- 01 BASIC SQL

-- Query 1: List the first 20 customers
SELECT * FROM customers ORDER BY customer_id LIMIT 20;

-- Query 2: Count all customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Query 3: Find customers aged 60 or above
SELECT customer_id, age, city, risk_segment FROM customers WHERE age >= 60 ORDER BY age DESC LIMIT 100;

-- Query 4: List distinct employment types
SELECT DISTINCT employment_type FROM customers ORDER BY employment_type;

-- Query 5: Find applications submitted in 2025
SELECT application_id, customer_id, application_date, loan_type, decision FROM applications WHERE application_date >= '2025-01-01' AND application_date < '2026-01-01' ORDER BY application_date;


-- 02 AGGREGATIONS

-- Query 6: Count applications by decision
SELECT decision, COUNT(*) AS application_count FROM applications GROUP BY decision ORDER BY application_count DESC;

-- Query 7: Average credit score by decision
SELECT decision, ROUND(AVG(credit_score),2) AS avg_credit_score FROM applications GROUP BY decision;

-- Query 8: Total requested amount by loan type
SELECT loan_type, SUM(requested_amount_inr) AS total_requested_inr FROM applications GROUP BY loan_type ORDER BY total_requested_inr DESC;

-- Query 9: Average customer income by employment type
SELECT employment_type, ROUND(AVG(annual_income_inr),2) AS avg_annual_income_inr FROM customers GROUP BY employment_type ORDER BY avg_annual_income_inr DESC;

-- Query 10: Count customers by risk segment
SELECT risk_segment, COUNT(*) AS customer_count FROM customers GROUP BY risk_segment ORDER BY customer_count DESC;

-- Query 11: Loan count and average principal by loan type
SELECT loan_type, COUNT(*) AS loan_count, ROUND(AVG(principal_amount_inr),2) AS avg_principal_inr FROM loans GROUP BY loan_type ORDER BY loan_count DESC;


-- 03 JOINS

-- Query 12: Applications with customer profile
SELECT a.application_id, a.loan_type, a.decision, c.customer_id, c.city, c.risk_segment FROM applications a INNER JOIN customers c ON a.customer_id=c.customer_id LIMIT 100;

-- Query 13: Loans with customer profile
SELECT l.loan_id, l.loan_type, l.principal_amount_inr, l.default_flag, c.city, c.employment_type, c.risk_segment FROM loans l INNER JOIN customers c ON l.customer_id=c.customer_id LIMIT 100;

-- Query 14: Loans with application decision details
SELECT l.loan_id, l.application_id, a.decision, a.decision_reason, l.principal_amount_inr FROM loans l INNER JOIN applications a ON l.application_id=a.application_id LIMIT 100;

-- Query 15: Repayments with loan details
SELECT r.repayment_id, r.loan_id, l.loan_type, r.payment_status, r.scheduled_amount_inr, r.paid_amount_inr FROM repayments r INNER JOIN loans l ON r.loan_id=l.loan_id LIMIT 100;

-- Query 16: Transactions with customer risk segment
SELECT t.transaction_id, t.amount_inr, t.fraud_flag, t.channel, c.risk_segment, c.city FROM transactions t INNER JOIN customers c ON t.customer_id=c.customer_id LIMIT 100;

-- Query 17: Customer loan and repayment summary
SELECT c.customer_id, c.risk_segment, COUNT(DISTINCT l.loan_id) AS loan_count, COUNT(r.repayment_id) AS installment_count, SUM(r.scheduled_amount_inr) AS scheduled_total, SUM(r.paid_amount_inr) AS paid_total FROM customers c LEFT JOIN loans l ON c.customer_id=l.customer_id LEFT JOIN repayments r ON l.loan_id=r.loan_id GROUP BY c.customer_id, c.risk_segment LIMIT 100;

-- Query 18: Customers with no loan accounts
SELECT c.customer_id, c.city, c.risk_segment FROM customers c LEFT JOIN loans l ON c.customer_id=l.customer_id WHERE l.loan_id IS NULL LIMIT 100;


-- 04 CASE WHEN

-- Query 19: Classify customer age groups
SELECT CASE WHEN age < 30 THEN 'Under 30' WHEN age < 45 THEN '30-44' WHEN age < 60 THEN '45-59' ELSE '60+' END AS age_group, COUNT(*) AS customers FROM customers GROUP BY age_group ORDER BY customers DESC;

-- Query 20: Classify application credit scores
SELECT CASE WHEN credit_score >= 750 THEN 'Excellent' WHEN credit_score >= 700 THEN 'Good' WHEN credit_score >= 650 THEN 'Fair' ELSE 'Low' END AS credit_band, COUNT(*) AS applications FROM applications GROUP BY credit_band ORDER BY applications DESC;

-- Query 21: Count approved and rejected applications by loan type
SELECT loan_type, SUM(CASE WHEN decision='Approved' THEN 1 ELSE 0 END) AS approved_count, SUM(CASE WHEN decision='Rejected' THEN 1 ELSE 0 END) AS rejected_count FROM applications GROUP BY loan_type ORDER BY loan_type;

-- Query 22: Calculate default and non-default loan counts
SELECT SUM(CASE WHEN default_flag=1 THEN 1 ELSE 0 END) AS defaulted_loans, SUM(CASE WHEN default_flag=0 THEN 1 ELSE 0 END) AS non_defaulted_loans FROM loans;

-- Query 23: Classify transaction amounts
SELECT CASE WHEN amount_inr < 1000 THEN 'Low' WHEN amount_inr < 10000 THEN 'Medium' ELSE 'High' END AS amount_band, COUNT(*) AS transaction_count, ROUND(AVG(fraud_flag)*100,3) AS fraud_rate_pct FROM transactions GROUP BY amount_band ORDER BY transaction_count DESC;


-- 05 SUBQUERIES

-- Query 24: Applications above average requested amount
SELECT application_id, customer_id, requested_amount_inr FROM applications WHERE requested_amount_inr > (SELECT AVG(requested_amount_inr) FROM applications) ORDER BY requested_amount_inr DESC LIMIT 100;

-- Query 25: Customers earning above overall average income
SELECT customer_id, annual_income_inr, city FROM customers WHERE annual_income_inr > (SELECT AVG(annual_income_inr) FROM customers) ORDER BY annual_income_inr DESC LIMIT 100;

-- Query 26: Loan types with above-average default rate
SELECT loan_type, AVG(default_flag)*100 AS default_rate_pct FROM loans GROUP BY loan_type HAVING AVG(default_flag) > (SELECT AVG(default_flag) FROM loans);

-- Query 27: Customers with at least one fraud-labelled transaction
SELECT customer_id FROM customers WHERE customer_id IN (SELECT DISTINCT customer_id FROM transactions WHERE fraud_flag=1) LIMIT 100;

-- Query 28: Loans with repayment below 70 percent of scheduled amount
SELECT loan_id, SUM(scheduled_amount_inr) AS scheduled_total, SUM(paid_amount_inr) AS paid_total, SUM(paid_amount_inr)/NULLIF(SUM(scheduled_amount_inr),0) AS repayment_ratio FROM repayments GROUP BY loan_id HAVING SUM(paid_amount_inr)/NULLIF(SUM(scheduled_amount_inr),0) < 0.70 ORDER BY repayment_ratio LIMIT 100;


-- 06 CTEs

-- Query 29: CTE: default rate by loan type
WITH type_stats AS (SELECT loan_type, COUNT(*) AS loans, SUM(default_flag) AS defaults FROM loans GROUP BY loan_type) SELECT loan_type, loans, defaults, ROUND(defaults/loans*100,2) AS default_rate_pct FROM type_stats ORDER BY default_rate_pct DESC;

-- Query 30: CTE: repayment summary per loan
WITH repay AS (SELECT loan_id, COUNT(*) AS installments, SUM(scheduled_amount_inr) AS scheduled, SUM(paid_amount_inr) AS paid FROM repayments GROUP BY loan_id) SELECT loan_id, installments, scheduled, paid, ROUND(paid/NULLIF(scheduled,0),4) AS repayment_ratio FROM repay ORDER BY repayment_ratio LIMIT 100;

-- Query 31: CTE: fraud rate by channel
WITH channel_stats AS (SELECT channel, COUNT(*) AS txn_count, SUM(fraud_flag) AS fraud_count FROM transactions GROUP BY channel) SELECT channel, txn_count, fraud_count, ROUND(fraud_count/txn_count*100,3) AS fraud_rate_pct FROM channel_stats ORDER BY fraud_rate_pct DESC;

-- Query 32: CTE: customer exposure by risk segment
WITH exposure AS (SELECT c.risk_segment, COUNT(l.loan_id) AS loan_count, SUM(l.principal_amount_inr) AS principal_total FROM customers c LEFT JOIN loans l ON c.customer_id=l.customer_id GROUP BY c.risk_segment) SELECT risk_segment, loan_count, principal_total FROM exposure ORDER BY principal_total DESC;

-- Query 33: CTE: overdue and missed installments by customer
WITH payment_flags AS (SELECT customer_id, SUM(payment_status='Overdue') AS overdue_count, SUM(payment_status='Missed') AS missed_count FROM repayments GROUP BY customer_id) SELECT customer_id, overdue_count, missed_count FROM payment_flags WHERE overdue_count>0 OR missed_count>0 ORDER BY missed_count DESC, overdue_count DESC LIMIT 100;


-- 07 WINDOW FUNCTIONS

-- Query 34: Rank loan types by average principal
SELECT loan_type, ROUND(AVG(principal_amount_inr),2) AS avg_principal, DENSE_RANK() OVER (ORDER BY AVG(principal_amount_inr) DESC) AS principal_rank FROM loans GROUP BY loan_type;

-- Query 35: Rank customers by annual income
SELECT customer_id, annual_income_inr, RANK() OVER (ORDER BY annual_income_inr DESC) AS income_rank FROM customers LIMIT 100;

-- Query 36: Number loans per customer
SELECT loan_id, customer_id, loan_type, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY disbursement_date, loan_id) AS customer_loan_number FROM loans LIMIT 100;

-- Query 37: Running transaction amount by customer and timestamp
SELECT customer_id, transaction_timestamp, amount_inr, SUM(amount_inr) OVER (PARTITION BY customer_id ORDER BY transaction_timestamp, transaction_id ROWS UNBOUNDED PRECEDING) AS running_transaction_amount FROM transactions LIMIT 100;

-- Query 38: Compare each installment payment with previous installment
SELECT loan_id, installment_number, paid_amount_inr, LAG(paid_amount_inr) OVER (PARTITION BY loan_id ORDER BY installment_number) AS previous_paid_amount FROM repayments LIMIT 100;

-- Query 39: Top 3 loans by principal within each loan type
WITH ranked AS (SELECT loan_id, loan_type, principal_amount_inr, ROW_NUMBER() OVER (PARTITION BY loan_type ORDER BY principal_amount_inr DESC) AS rn FROM loans) SELECT loan_id, loan_type, principal_amount_inr, rn FROM ranked WHERE rn<=3 ORDER BY loan_type, rn;

-- Query 40: Compare transaction amount to customer average
SELECT transaction_id, customer_id, amount_inr, ROUND(AVG(amount_inr) OVER (PARTITION BY customer_id),2) AS customer_avg_amount, ROUND(amount_inr-AVG(amount_inr) OVER (PARTITION BY customer_id),2) AS difference_from_avg FROM transactions LIMIT 100;


-- 08 CREDIT RISK ANALYSIS

-- Query 41: Default rate by customer risk segment
SELECT c.risk_segment, COUNT(l.loan_id) AS loans, SUM(l.default_flag) AS defaults, ROUND(AVG(l.default_flag)*100,2) AS default_rate_pct FROM loans l JOIN customers c ON l.customer_id=c.customer_id GROUP BY c.risk_segment ORDER BY default_rate_pct DESC;

-- Query 42: Default rate by loan type
SELECT loan_type, COUNT(*) AS total_loans, SUM(default_flag) AS defaulted_loans, ROUND(AVG(default_flag)*100,2) AS default_rate_pct FROM loans GROUP BY loan_type ORDER BY default_rate_pct DESC;

-- Query 43: Default rate by credit score band at origination
SELECT CASE WHEN credit_score_at_origination<600 THEN 'Below 600' WHEN credit_score_at_origination<650 THEN '600-649' WHEN credit_score_at_origination<700 THEN '650-699' WHEN credit_score_at_origination<750 THEN '700-749' ELSE '750+' END AS score_band, COUNT(*) AS loans, ROUND(AVG(default_flag)*100,2) AS default_rate_pct FROM loans GROUP BY score_band ORDER BY score_band;

-- Query 44: Loan principal exposure by risk segment and default status
SELECT c.risk_segment, l.default_flag, COUNT(*) AS loan_count, SUM(l.principal_amount_inr) AS principal_exposure_inr FROM loans l JOIN customers c ON l.customer_id=c.customer_id GROUP BY c.risk_segment, l.default_flag ORDER BY c.risk_segment, l.default_flag;


-- 09 FRAUD ANALYSIS

-- Query 45: Overall transaction fraud rate
SELECT COUNT(*) AS total_transactions, SUM(fraud_flag) AS fraud_transactions, ROUND(AVG(fraud_flag)*100,3) AS fraud_rate_pct FROM transactions;

-- Query 46: Fraud rate by transaction channel
SELECT channel, COUNT(*) AS transactions, SUM(fraud_flag) AS fraud_count, ROUND(AVG(fraud_flag)*100,3) AS fraud_rate_pct FROM transactions GROUP BY channel ORDER BY fraud_rate_pct DESC;

-- Query 47: Fraud rate by device and international signals
SELECT device_new_flag, international_flag, COUNT(*) AS transactions, SUM(fraud_flag) AS fraud_count, ROUND(AVG(fraud_flag)*100,3) AS fraud_rate_pct FROM transactions GROUP BY device_new_flag, international_flag ORDER BY fraud_rate_pct DESC;


-- 10 REPAYMENT ANALYSIS

-- Query 48: Installment counts by payment status
SELECT payment_status, COUNT(*) AS installment_count, ROUND(AVG(scheduled_amount_inr),2) AS avg_scheduled, ROUND(AVG(paid_amount_inr),2) AS avg_paid FROM repayments GROUP BY payment_status ORDER BY installment_count DESC;

-- Query 49: Net scheduled-minus-paid amount by payment status
SELECT payment_status, SUM(scheduled_amount_inr) AS scheduled_total, SUM(paid_amount_inr) AS paid_total, SUM(scheduled_amount_inr-paid_amount_inr) AS net_difference_inr FROM repayments GROUP BY payment_status ORDER BY net_difference_inr DESC;

-- Query 50: Loans with highest missed and overdue installment counts
SELECT loan_id, SUM(payment_status='Missed') AS missed_installments, SUM(payment_status='Overdue') AS overdue_installments, SUM(scheduled_amount_inr-paid_amount_inr) AS net_unpaid_scheduled_inr FROM repayments GROUP BY loan_id ORDER BY missed_installments DESC, overdue_installments DESC LIMIT 100;