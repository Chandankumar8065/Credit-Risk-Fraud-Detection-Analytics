-- Credit Risk & Fraud Detection Analytics
-- MySQL 8.0 | Database and table setup
-- Source data: five uploaded synthetic CSV files

CREATE DATABASE IF NOT EXISTS CreditRiskFraudDB;
USE CreditRiskFraudDB;

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    age INT,
    city VARCHAR(100),
    employment_type VARCHAR(50),
    annual_income_inr BIGINT,
    existing_monthly_debt_inr BIGINT,
    customer_since DATE,
    kyc_status VARCHAR(30),
    risk_segment VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS applications (
    application_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    application_date DATE,
    loan_type VARCHAR(50),
    requested_amount_inr BIGINT,
    annual_income_inr BIGINT,
    credit_score INT,
    debt_to_income_ratio DECIMAL(8,5),
    employment_stability_score DECIMAL(8,5),
    decision VARCHAR(30),
    decision_reason VARCHAR(100),
    CONSTRAINT fk_app_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    application_id VARCHAR(20) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    loan_type VARCHAR(50),
    disbursement_date DATE,
    principal_amount_inr BIGINT,
    annual_interest_rate_pct DECIMAL(7,3),
    tenure_months INT,
    credit_score_at_origination INT,
    debt_to_income_ratio_at_origination DECIMAL(8,5),
    default_flag TINYINT,
    account_status VARCHAR(30),
    CONSTRAINT fk_loan_application FOREIGN KEY (application_id)
        REFERENCES applications(application_id),
    CONSTRAINT fk_loan_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    transaction_timestamp DATETIME,
    transaction_type VARCHAR(50),
    channel VARCHAR(50),
    merchant_category VARCHAR(50),
    amount_inr DECIMAL(15,2),
    device_new_flag TINYINT,
    international_flag TINYINT,
    transactions_last_24h INT,
    transaction_status VARCHAR(30),
    fraud_flag TINYINT,
    fraud_reason_signal VARCHAR(100),
    CONSTRAINT fk_txn_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS repayments (
    repayment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    installment_number INT,
    due_date DATE,
    scheduled_amount_inr DECIMAL(15,2),
    paid_amount_inr DECIMAL(15,2),
    payment_status VARCHAR(30),
    days_late INT,
    payment_difference DECIMAL(15,2),
    CONSTRAINT fk_repay_loan FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id),
    CONSTRAINT fk_repay_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- After CSV import, verify all five tables:
SHOW TABLES;