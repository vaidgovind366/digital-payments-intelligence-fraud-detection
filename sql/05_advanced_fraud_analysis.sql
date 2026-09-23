-- Create a complete customer-level transaction and fraud summary
WITH customer_metrics AS (
    SELECT
        Customer_ID,
        COUNT(*) AS Total_Transactions,
        ROUND(SUM(Amount), 2) AS Total_Spend,
        ROUND(AVG(Amount), 2) AS Average_Transaction,
        SUM(CASE WHEN Transaction_Status = 'Successful' THEN 1 ELSE 0 END) AS Successful_Transactions,
        SUM(CASE WHEN Transaction_Status = 'Failed' THEN 1 ELSE 0 END) AS Failed_Transactions,
        SUM(Fraud_Flag) AS Fraud_Transactions,
        MAX(Risk_Score) AS Max_Risk_Score,
        ROUND(AVG(Risk_Score), 2) AS Average_Risk_Score
    FROM transactions
    GROUP BY Customer_ID
)
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.State,
    c.Customer_Segment,
    cm.Total_Transactions,
    cm.Total_Spend,
    cm.Average_Transaction,
    cm.Successful_Transactions,
    cm.Failed_Transactions,
    cm.Fraud_Transactions,
    cm.Max_Risk_Score,
    cm.Average_Risk_Score
FROM customers c
JOIN customer_metrics cm
    ON c.Customer_ID = cm.Customer_ID
ORDER BY cm.Total_Spend DESC;

-- Find customers with high risk scores
SELECT
    Customer_ID,
    COUNT(*) AS Total_Transactions,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Spend,
    MAX(Risk_Score) AS Max_Risk_Score,
    ROUND(AVG(Risk_Score), 2) AS Average_Risk_Score
FROM transactions
GROUP BY Customer_ID
HAVING MAX(Risk_Score) >= 61
ORDER BY Max_Risk_Score DESC, Fraud_Transactions DESC, Total_Spend DESC
LIMIT 20;

-- Identify unusually high transaction velocity
SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Timestamp,
    Velocity_10Min_Count,
    Amount,
    Fraud_Flag,
    Risk_Score,
    Risk_Level
FROM transactions
WHERE Velocity_10Min_Count >= 3
ORDER BY Velocity_10Min_Count DESC, Risk_Score DESC;

-- Calculate fraud rate for high-velocity transactions
SELECT
    Velocity_10Min_Count,
    COUNT(*) AS Total_Transactions,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(100.0 * SUM(Fraud_Flag) / COUNT(*), 2) AS Fraud_Rate_Percent
FROM transactions
WHERE Velocity_10Min_Count >= 2
GROUP BY Velocity_10Min_Count
ORDER BY Velocity_10Min_Count;

-- Identify transactions with unusually high amounts compared with customer behavior
WITH customer_baseline AS (
    SELECT
        Customer_ID,
        AVG(Amount) AS Average_Amount
    FROM transactions
    GROUP BY Customer_ID
)
SELECT
    t.Transaction_ID,
    t.Customer_ID,
    ROUND(t.Amount, 2) AS Transaction_Amount,
    ROUND(cb.Average_Amount, 2) AS Customer_Average_Amount,
    ROUND(
        100.0 * (t.Amount - cb.Average_Amount)
        / NULLIF(cb.Average_Amount, 0),
        2
    ) AS Deviation_Percent,
    t.Fraud_Flag,
    t.Risk_Score,
    t.Risk_Level
FROM transactions t
JOIN customer_baseline cb
    ON t.Customer_ID = cb.Customer_ID
WHERE t.Amount > cb.Average_Amount * 3
ORDER BY Deviation_Percent DESC;

-- Identify successful transactions preceded by two failed transactions
WITH transaction_sequence AS (
    SELECT
        Transaction_ID,
        Customer_ID,
        Transaction_Timestamp,
        Transaction_Status,
        Amount,
        Fraud_Flag,
        Risk_Score,
        LAG(Transaction_Status, 1) OVER (
            PARTITION BY Customer_ID
            ORDER BY Transaction_Timestamp
        ) AS Previous_Status_1,
        LAG(Transaction_Status, 2) OVER (
            PARTITION BY Customer_ID
            ORDER BY Transaction_Timestamp
        ) AS Previous_Status_2
    FROM transactions
)
SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Timestamp,
    Amount,
    Fraud_Flag,
    Risk_Score
FROM transaction_sequence
WHERE Transaction_Status = 'Successful'
  AND Previous_Status_1 = 'Failed'
  AND Previous_Status_2 = 'Failed'
ORDER BY Risk_Score DESC, Transaction_Timestamp;

-- Create a fraud investigation result set
SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Timestamp,
    Amount,
    Payment_Method,
    Location,
    State,
    Risk_Score,
    Risk_Level,
    Fraud_Reason,
    New_Device_Flag,
    Location_Mismatch_Flag,
    Unusual_Hour_Flag,
    IP_Mismatch_Flag,
    Failed_Burst_Flag
FROM transactions
WHERE Risk_Score >= 61
ORDER BY Risk_Score DESC, Amount DESC;

-- Count flagged behavioral indicators
SELECT
    SUM(New_Device_Flag) AS New_Device_Flags,
    SUM(Location_Mismatch_Flag) AS Location_Mismatch_Flags,
    SUM(Unusual_Hour_Flag) AS Unusual_Hour_Flags,
    SUM(IP_Mismatch_Flag) AS IP_Mismatch_Flags,
    SUM(Failed_Burst_Flag) AS Failed_Burst_Flags,
    SUM(Merchant_Risk_Flag) AS Merchant_Risk_Flags
FROM transactions;

-- Count fraud transactions associated with behavioral indicators
SELECT
    SUM(CASE WHEN New_Device_Flag = 1 AND Fraud_Flag = 1 THEN 1 ELSE 0 END) AS New_Device_Fraud,
    SUM(CASE WHEN Location_Mismatch_Flag = 1 AND Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Location_Mismatch_Fraud,
    SUM(CASE WHEN Unusual_Hour_Flag = 1 AND Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Unusual_Hour_Fraud,
    SUM(CASE WHEN IP_Mismatch_Flag = 1 AND Fraud_Flag = 1 THEN 1 ELSE 0 END) AS IP_Mismatch_Fraud,
    SUM(CASE WHEN Failed_Burst_Flag = 1 AND Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Failed_Burst_Fraud
FROM transactions;

-- Generate an executive summary of payment performance
SELECT
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Transaction_Value,
    ROUND(AVG(Amount), 2) AS Average_Transaction_Value,
    SUM(CASE WHEN Transaction_Status = 'Successful' THEN 1 ELSE 0 END) AS Successful_Transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Transaction_Status = 'Successful' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS Success_Rate_Percent,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(100.0 * SUM(Fraud_Flag) / COUNT(*), 2) AS Fraud_Rate_Percent,
    SUM(CASE WHEN Risk_Level = 'High' THEN 1 ELSE 0 END) AS High_Risk_Transactions,
    ROUND(AVG(Risk_Score), 2) AS Average_Risk_Score
FROM transactions;
