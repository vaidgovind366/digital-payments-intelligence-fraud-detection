-- Check the active database
SELECT DATABASE();

-- Check available tables
SHOW TABLES;

-- Check customer table structure
DESCRIBE customers;

-- Check transaction table structure
DESCRIBE transactions;

-- Count customer records
SELECT COUNT(*) AS Total_Customers
FROM customers;

-- Count transaction records
SELECT COUNT(*) AS Total_Transactions
FROM transactions;

-- Check duplicate customer IDs
SELECT Customer_ID, COUNT(*) AS Duplicate_Count
FROM customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Check duplicate transaction IDs
SELECT Transaction_ID, COUNT(*) AS Duplicate_Count
FROM transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

-- Check transactions without a matching customer
SELECT COUNT(*) AS Unmatched_Transactions
FROM transactions t
LEFT JOIN customers c
    ON t.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

-- Check missing customer IDs in transactions
SELECT COUNT(*) AS Missing_Customer_ID
FROM transactions
WHERE Customer_ID IS NULL;

-- Check transaction date range
SELECT
    MIN(Transaction_Date) AS First_Transaction_Date,
    MAX(Transaction_Date) AS Last_Transaction_Date
FROM transactions;

-- Check fraud distribution
SELECT
    Fraud_Flag,
    COUNT(*) AS Transaction_Count
FROM transactions
GROUP BY Fraud_Flag;

-- Check risk-level distribution
SELECT
    Risk_Level,
    COUNT(*) AS Transaction_Count
FROM transactions
GROUP BY Risk_Level
ORDER BY Transaction_Count DESC;
