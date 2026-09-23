-- Calculate overall transaction performance
SELECT
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Transaction_Amount,
    ROUND(AVG(Amount), 2) AS Average_Transaction_Amount
FROM transactions;

-- Analyze successful, failed, and pending transactions
SELECT
    Transaction_Status,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM transactions
GROUP BY Transaction_Status
ORDER BY Transaction_Count DESC;

-- Compare transaction performance across payment methods
SELECT
    Payment_Method,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    ROUND(AVG(Amount), 2) AS Average_Amount
FROM transactions
GROUP BY Payment_Method
ORDER BY Total_Transactions DESC;

-- Calculate overall fraud performance
SELECT
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(SUM(CASE WHEN Fraud_Flag = 1 THEN Amount ELSE 0 END), 2) AS Fraud_Amount,
    ROUND(100.0 * SUM(Fraud_Flag) / COUNT(*), 2) AS Fraud_Rate_Percent
FROM transactions;

-- Analyze fraud by reason
SELECT
    Fraud_Reason,
    COUNT(*) AS Fraud_Transactions,
    ROUND(SUM(Amount), 2) AS Fraud_Amount,
    ROUND(AVG(Risk_Score), 2) AS Average_Risk_Score
FROM transactions
WHERE Fraud_Flag = 1
GROUP BY Fraud_Reason
ORDER BY Fraud_Transactions DESC;

-- Analyze transaction distribution by risk level
SELECT
    Risk_Level,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    ROUND(AVG(Risk_Score), 2) AS Average_Risk_Score
FROM transactions
GROUP BY Risk_Level
ORDER BY Average_Risk_Score DESC;

-- Analyze transactions and fraud by state
SELECT
    State,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(100.0 * SUM(Fraud_Flag) / COUNT(*), 2) AS Fraud_Rate_Percent
FROM transactions
GROUP BY State
ORDER BY Total_Amount DESC;

-- Analyze monthly transaction and fraud trends
SELECT
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    SUM(Fraud_Flag) AS Fraud_Transactions
FROM transactions
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY Month;

-- Identify high-risk transactions
SELECT
    Transaction_ID,
    Customer_ID,
    Amount,
    Risk_Score,
    Risk_Level,
    Fraud_Reason,
    Payment_Method,
    Location,
    Transaction_Timestamp
FROM transactions
WHERE Risk_Level = 'High'
ORDER BY Risk_Score DESC, Amount DESC
LIMIT 100;

-- Find top customers by spending
SELECT
    Customer_ID,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Spend,
    ROUND(AVG(Amount), 2) AS Average_Transaction
FROM transactions
GROUP BY Customer_ID
ORDER BY Total_Spend DESC
LIMIT 10;

-- Identify customers with fraud activity
SELECT
    Customer_ID,
    COUNT(*) AS Total_Transactions,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Spend,
    MAX(Risk_Score) AS Max_Risk_Score
FROM transactions
GROUP BY Customer_ID
HAVING SUM(Fraud_Flag) > 0
ORDER BY Fraud_Transactions DESC, Max_Risk_Score DESC;

-- Analyze fraud activity by transaction hour
SELECT
    HOUR(Transaction_Timestamp) AS Transaction_Hour,
    COUNT(*) AS Total_Transactions,
    SUM(Fraud_Flag) AS Fraud_Transactions,
    ROUND(100.0 * SUM(Fraud_Flag) / COUNT(*), 2) AS Fraud_Rate_Percent
FROM transactions
GROUP BY HOUR(Transaction_Timestamp)
ORDER BY Transaction_Hour;

-- Rank customers by total spending
WITH customer_spend AS (
    SELECT
        Customer_ID,
        SUM(Amount) AS Total_Spend
    FROM transactions
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    ROUND(Total_Spend, 2) AS Total_Spend,
    RANK() OVER (ORDER BY Total_Spend DESC) AS Spend_Rank
FROM customer_spend
ORDER BY Spend_Rank;

-- Calculate month-over-month transaction value growth
WITH monthly_data AS (
    SELECT
        DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
        SUM(Amount) AS Total_Amount
    FROM transactions
    GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
),
monthly_growth AS (
    SELECT
        Month,
        Total_Amount,
        LAG(Total_Amount) OVER (ORDER BY Month) AS Previous_Month_Amount
    FROM monthly_data
)
SELECT
    Month,
    ROUND(Total_Amount, 2) AS Total_Amount,
    ROUND(Previous_Month_Amount, 2) AS Previous_Month_Amount,
    ROUND(
        100.0 * (Total_Amount - Previous_Month_Amount)
        / NULLIF(Previous_Month_Amount, 0),
        2
    ) AS MoM_Growth_Percent
FROM monthly_growth
ORDER BY Month;
