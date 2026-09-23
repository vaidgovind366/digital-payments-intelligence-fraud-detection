-- Create a reusable customer 360 view
CREATE OR REPLACE VIEW v_customer_360 AS
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.State,
    c.Customer_Segment,
    COUNT(t.Transaction_ID) AS Total_Transactions,
    ROUND(SUM(t.Amount), 2) AS Total_Spend,
    ROUND(AVG(t.Amount), 2) AS Average_Transaction,
    SUM(CASE WHEN t.Transaction_Status = 'Successful' THEN 1 ELSE 0 END) AS Successful_Transactions,
    SUM(CASE WHEN t.Transaction_Status = 'Failed' THEN 1 ELSE 0 END) AS Failed_Transactions,
    SUM(t.Fraud_Flag) AS Fraud_Transactions,
    MAX(t.Risk_Score) AS Max_Risk_Score,
    ROUND(AVG(t.Risk_Score), 2) AS Average_Risk_Score
FROM customers c
LEFT JOIN transactions t
    ON c.Customer_ID = t.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.State,
    c.Customer_Segment;

-- Create a reusable fraud investigation view
CREATE OR REPLACE VIEW v_fraud_investigation AS
SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Timestamp,
    Amount,
    Payment_Method,
    Transaction_Status,
    Location,
    State,
    Risk_Score,
    Risk_Level,
    Fraud_Flag,
    Fraud_Reason,
    New_Device_Flag,
    Location_Mismatch_Flag,
    Unusual_Hour_Flag,
    IP_Mismatch_Flag,
    Failed_Burst_Flag
FROM transactions
WHERE Fraud_Flag = 1
   OR Risk_Score >= 61;

-- Create a reusable monthly performance view
CREATE OR REPLACE VIEW v_monthly_performance AS
SELECT
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    SUM(CASE WHEN Transaction_Status = 'Successful' THEN 1 ELSE 0 END) AS Successful_Transactions,
    SUM(CASE WHEN Transaction_Status = 'Failed' THEN 1 ELSE 0 END) AS Failed_Transactions,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(100.0 * SUM(Fraud_Flag) / COUNT(*), 2) AS Fraud_Rate_Percent
FROM transactions
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m');

-- Display the customer 360 view
SELECT *
FROM v_customer_360
LIMIT 20;

-- Display the fraud investigation view
SELECT *
FROM v_fraud_investigation
ORDER BY Risk_Score DESC, Amount DESC
LIMIT 20;

-- Display the monthly performance view
SELECT *
FROM v_monthly_performance
ORDER BY Month;
