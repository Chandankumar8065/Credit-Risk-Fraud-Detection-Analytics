-- Post-import validation checks | MySQL 8.0
USE CreditRiskFraudDB;
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'applications', COUNT(*) FROM applications
UNION ALL SELECT 'loans', COUNT(*) FROM loans
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'repayments', COUNT(*) FROM repayments;

-- Primary-key duplicate checks (each should return zero)
SELECT COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids FROM customers;
SELECT COUNT(*) - COUNT(DISTINCT application_id) AS duplicate_application_ids FROM applications;
SELECT COUNT(*) - COUNT(DISTINCT loan_id) AS duplicate_loan_ids FROM loans;
SELECT COUNT(*) - COUNT(DISTINCT transaction_id) AS duplicate_transaction_ids FROM transactions;
SELECT COUNT(*) - COUNT(DISTINCT repayment_id) AS duplicate_repayment_ids FROM repayments;

-- Foreign-key orphan checks (each should return zero)
SELECT COUNT(*) AS orphan_applications FROM applications a LEFT JOIN customers c ON a.customer_id=c.customer_id WHERE c.customer_id IS NULL;
SELECT COUNT(*) AS orphan_loans_application FROM loans l LEFT JOIN applications a ON l.application_id=a.application_id WHERE a.application_id IS NULL;
SELECT COUNT(*) AS orphan_loans_customer FROM loans l LEFT JOIN customers c ON l.customer_id=c.customer_id WHERE c.customer_id IS NULL;
SELECT COUNT(*) AS orphan_transactions FROM transactions t LEFT JOIN customers c ON t.customer_id=c.customer_id WHERE c.customer_id IS NULL;
SELECT COUNT(*) AS orphan_repayments_loan FROM repayments r LEFT JOIN loans l ON r.loan_id=l.loan_id WHERE l.loan_id IS NULL;
SELECT COUNT(*) AS orphan_repayments_customer FROM repayments r LEFT JOIN customers c ON r.customer_id=c.customer_id WHERE c.customer_id IS NULL;