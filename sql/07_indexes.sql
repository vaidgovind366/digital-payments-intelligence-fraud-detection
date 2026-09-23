-- Improve customer-level query performance
CREATE INDEX idx_transactions_customer
ON transactions(Customer_ID);

-- Improve date-based query performance
CREATE INDEX idx_transactions_date
ON transactions(Transaction_Date);

-- Improve fraud analysis query performance
CREATE INDEX idx_transactions_fraud
ON transactions(Fraud_Flag);

-- Improve risk analysis query performance
CREATE INDEX idx_transactions_risk
ON transactions(Risk_Score);

-- Improve payment-method query performance
CREATE INDEX idx_transactions_payment
ON transactions(Payment_Method);

-- Verify indexes on the transactions table
SHOW INDEX FROM transactions;
