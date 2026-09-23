# Digital Payments Intelligence & Fraud Detection

An end-to-end Data Analytics project built using Python, MySQL, SQL, and Power BI to analyze digital payment transactions, customer behavior, fraud patterns, and risk indicators.

---

## 📌 Project Overview

Digital payment platforms process a large number of transactions every day. Analyzing transaction performance, customer behavior, suspicious activities, and risk indicators can help businesses understand payment operations and prioritize potentially risky transactions.

This project analyzes:

- 100,000 digital payment transactions
- 10,000 customers
- Transaction data covering 2021–2025

The project combines Python for data analysis, MySQL for structured data storage and advanced SQL analysis, and Power BI for interactive business intelligence dashboards.

---

## 🎯 Problem Statement

The objective of this project is to build an analytical framework for monitoring digital payment activity and identifying potentially suspicious transactions using transaction-level and behavioral risk indicators.

The analysis focuses on transaction performance, fraud patterns, customer behavior, risk levels, and suspicious activity.

---

## 🎯 Business Objectives

- Monitor overall digital payment performance
- Analyze successful, failed, and pending transactions
- Identify fraud trends and fraud reasons
- Analyze customer spending behavior
- Identify high-risk customers and transactions
- Analyze behavioral indicators associated with suspicious activity
- Understand payment method and state-level transaction patterns
- Create an interactive dashboard for business users
- Provide an investigation queue for high-risk transactions

---

## 🛠️ Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- MySQL
- SQL
- Power BI
- DAX
- Jupyter Notebook
- GitHub

---

## 📊 Dataset

The project contains two main datasets.

### Customers Dataset

Contains customer profile and demographic information.

Key fields include:

- Customer_ID
- Customer_Name
- Age
- Gender
- City
- State
- Customer_Since
- Customer_Segment
- KYC_Status
- Home_Device_ID_1
- Home_Device_ID_2
- Baseline_Avg_Amount

### Transactions Dataset

Contains transaction-level information.

Key fields include:

- Transaction_ID
- Transaction_Timestamp
- Transaction_Date
- Customer_ID
- Account_ID
- Merchant_ID
- Payment_Method
- Transaction_Type
- Amount
- Transaction_Status
- Device_Type
- Device_ID
- Location
- State
- Network_Type
- Transaction_Channel
- Transaction Velocity
- Amount Deviation
- New Device Flag
- Location Mismatch Flag
- Unusual Hour Flag
- IP Mismatch Flag
- Failed Burst Flag
- Merchant Risk Flag
- Fraud Flag
- Fraud Reason
- Risk Score
- Risk Level

---

## 🔄 Project Architecture

```text
Raw Data
   ↓
Python
   ↓
Data Cleaning & Exploratory Data Analysis
   ↓
MySQL
   ↓
SQL Analysis & Fraud Investigation
   ↓
Power BI
   ↓
Interactive Business Intelligence Dashboard
```

---

# 🐍 Python Analysis

Python was used for data preparation, exploratory data analysis, fraud analysis, customer profiling, statistical analysis, and visualization.

### Data Preparation

The Python analysis included:

- Loading CSV datasets
- Checking dataset dimensions
- Inspecting data types
- Missing value analysis
- Duplicate analysis
- Date and time conversion
- Creating Year, Month, Day, Hour and Day Name fields
- Validating customer and transaction relationships

### Transaction Analysis

The analysis covered:

- Total transactions
- Transaction amount
- Average transaction amount
- Transaction status
- Payment method
- Monthly transaction trends
- Transaction distribution

### Fraud Analysis

The fraud analysis included:

- Fraud transaction count
- Fraud rate
- Fraud amount
- Fraud reasons
- Fraud trends
- Fraud by hour
- Fraud by payment method
- Fraud by state
- Fraud vs non-fraud analysis

### Behavioral Analysis

Behavioral indicators analyzed include:

- New device activity
- Location mismatch
- Unusual transaction hours
- IP mismatch
- Failed transaction bursts
- Merchant risk
- Transaction velocity
- Amount deviation

### Customer Risk Analysis

Customer-level analysis was performed to identify:

- Customer transaction frequency
- Customer spending
- Average transaction amount
- Fraud activity
- Risk scores
- Customer risk levels
- High-risk customers

Customer risk levels were classified as:

- Low
- Medium
- High

### Statistical Analysis

Statistical techniques were also used to compare transaction behavior and identify relationships between variables.

The analysis included:

- Mann-Whitney U Test
- Chi-Square Test

---

# 🗄️ MySQL & SQL Analysis

MySQL was used to store and analyze the customer and transaction data.

The project includes both basic and advanced SQL analysis.

### Core SQL Analysis

The SQL analysis covers:

- Overall transaction performance
- Transaction status analysis
- Payment method analysis
- Fraud overview
- Fraud reason analysis
- Risk level analysis
- State-wise transaction analysis
- Monthly transaction trends
- High-risk transaction analysis
- Top customers by spending
- Customer fraud analysis
- Fraud by transaction hour

### Advanced SQL

Advanced SQL techniques used in this project include:

- JOINs
- CTEs
- Window Functions
- RANK()
- LAG()
- CASE statements
- Aggregate Functions
- Subqueries
- Views
- Indexes

### Advanced Fraud Analysis

The project also analyzes:

- Customer 360 profiles
- High-risk customers
- Transaction velocity
- Amount anomalies
- Failed transaction bursts
- Behavioral fraud indicators
- Fraud investigation queue
- Risk-based transaction prioritization

---

# 📈 Power BI Dashboard

The Power BI dashboard contains three analytical pages.

---

## Page 1 — Payment Intelligence

This page provides an overview of digital payment performance.

### Key KPIs

- Total Transactions
- Total Transaction Amount
- Average Transaction Amount
- Successful Transactions
- Success Rate
- Failed Transactions

### Visual Analysis

- Monthly Transaction Trend
- Payment Method Analysis
- Transaction Status
- State Analysis
- Device / Platform Analysis
- Year-wise Transaction Trend

This page helps understand the overall performance and behavior of the payment ecosystem.

---

## Page 2 — Fraud Detection

This page focuses on fraud patterns and suspicious transaction activity.

### Key KPIs

- Fraud Transactions
- Fraud Amount
- Fraud Rate
- High-Risk Transactions
- Average Fraud Risk Score

### Visual Analysis

- Fraud Trend
- Fraud by Payment Method
- Fraud Reasons
- Fraud by State
- Fraud by Hour
- Fraud vs Non-Fraud

This page helps users analyze where and when suspicious transaction activity occurs.

---

## Page 3 — Customer & Risk Intelligence

This page focuses on customer behavior and risk profiling.

### Key KPIs

- Total Customers
- High-Risk Customers
- Transactions per Customer
- Average Customer Spend
- Suspicious Transactions

### Visual Analysis

- Customer Risk Distribution
- Top High-Risk Customers
- Transaction Frequency
- Risk Score Distribution
- Fraud by Customer Risk
- Behavioral Analysis
- Investigation Queue

This page helps prioritize customers and transactions that require further investigation.

---

# 🔎 Fraud & Risk Detection Approach

The project uses predefined transaction-level and behavioral indicators to analyze potentially suspicious activity.

The indicators include:

- New Device
- Location Mismatch
- Unusual Hour
- IP Mismatch
- Failed Transaction Burst
- Merchant Risk
- Transaction Velocity
- Amount Deviation

A risk score is used to categorize transactions into:

```text
Low Risk
Medium Risk
High Risk
```

The fraud and risk fields in this project are based on predefined analytical and rule-based indicators.

This project does not claim to use a machine learning model for fraud prediction.

---

# 📌 Key Business Questions

This project helps answer questions such as:

1. What is the total transaction volume?
2. What is the total transaction value?
3. What percentage of transactions are successful?
4. Which payment methods are most frequently used?
5. What percentage of transactions are flagged as fraudulent?
6. Which fraud reasons occur most frequently?
7. Which states have higher fraud activity?
8. Which hours show higher suspicious activity?
9. Which customers have the highest spending?
10. Which customers have higher risk scores?
11. Which behavioral indicators are associated with suspicious transactions?
12. How does fraud activity change over time?
13. Which transactions should be prioritized for investigation?
14. What is the relationship between customer behavior and transaction risk?

---

# 💡 Key Analytical Areas

The project focuses on four major areas:

### 1. Payment Intelligence

Understanding transaction volume, transaction value, payment methods, transaction status, and monthly trends.

### 2. Fraud Intelligence

Analyzing fraud volume, fraud rate, fraud reasons, fraud trends, and suspicious transaction patterns.

### 3. Customer Intelligence

Understanding customer spending behavior, transaction frequency, customer segments, and high-value customers.

### 4. Risk Intelligence

Analyzing risk scores, risk levels, behavioral indicators, high-risk customers, and investigation queues.

---

# 📁 Project Structure

```text
digital-payments-intelligence-fraud-detection/
│
├── data/
│   ├── transactions_100k.csv
│   └── customers.csv
│
├── python/
│   ├── 01_data_loading.ipynb
│   ├── 02_data_quality.ipynb
│   ├── 03_fraud_analysis.ipynb
│   └── outputs/
│       ├── fraud_reason_analysis.csv
│       ├── behavior_analysis.csv
│       ├── customer_risk_analysis.csv
│       ├── monthly_fraud_analysis.csv
│       ├── hourly_fraud_analysis.csv
│       ├── investigation_queue.csv
│       └── project_summary.csv
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_create_tables.sql
│   ├── 03_data_validation.sql
│   ├── 04_core_analysis.sql
│   ├── 05_advanced_fraud_analysis.sql
│   ├── 06_views.sql
│   └── 07_indexes.sql
│
├── powerbi/
│   └── Digital_Payments_Intelligence.pbix
│
├── screenshots/
│   ├── page1_payment_intelligence.png
│   ├── page2_fraud_detection.png
│   └── page3_customer_risk.png
│
└── README.md
```

---

# 📂 SQL Files

The SQL folder contains seven organized files:

### 01_database_setup.sql

Creates the project database and selects the database.

### 02_create_tables.sql

Creates the customer and transaction tables.

### 03_data_validation.sql

Performs database and data quality validation.

### 04_core_analysis.sql

Contains the main transaction, fraud, customer, state, payment method, and trend analysis.

### 05_advanced_fraud_analysis.sql

Contains advanced fraud analysis using CTEs, window functions, behavioral indicators, and investigation logic.

### 06_views.sql

Creates reusable SQL views for:

- Customer 360
- Fraud Investigation
- Monthly Performance

### 07_indexes.sql

Creates indexes to improve query performance for frequently analyzed fields.

---

# 📊 Dashboard Design

The dashboard uses a modern dark fintech-style design.

### Design Elements

- Dark navy background
- Blue and cyan highlights
- Risk-focused visual indicators
- KPI cards
- Interactive charts
- Trend analysis
- Customer risk visualization
- Fraud investigation table

The dashboard is designed for business users to quickly understand payment performance and suspicious activity.

---

# 🚀 Business Value

This project demonstrates how multiple data analytics technologies can be combined to create an end-to-end analytics solution.

The workflow connects:

```text
Python
↓
Data Analysis
↓
SQL
↓
Data Investigation
↓
Power BI
↓
Business Insights
```

The solution can help analysts and business teams monitor transaction performance, understand customer behavior, analyze fraud patterns, and prioritize potentially risky transactions for investigation.

---

# 🚀 Future Enhancements

Future versions of the project can include:

- Machine Learning-based fraud prediction
- Real-time transaction monitoring
- Automated fraud alerts
- Advanced anomaly detection
- Customer churn prediction
- Real-time Power BI integration
- Automated risk scoring
- Model performance monitoring
- Real-time fraud investigation workflows

---

# 🎓 Skills Demonstrated

- Data Cleaning
- Exploratory Data Analysis
- Data Analysis
- Python
- Pandas
- NumPy
- Matplotlib
- SQL
- MySQL
- Advanced SQL
- CTEs
- Window Functions
- SQL Views
- SQL Indexes
- Power BI
- DAX
- Data Visualization
- Customer Analytics
- Fraud Analytics
- Risk Analysis
- Business Intelligence
- Statistical Analysis
- GitHub

---

# 👨‍💻 Author

## Govind Vaid

BSc Computer Science | Data Analytics

### Skills

Python | SQL | MySQL | Power BI | Excel | Data Analysis

---

# ⭐ Project Summary

**Digital Payments Intelligence & Fraud Detection** is an end-to-end Data Analytics project combining Python, SQL, MySQL, and Power BI to analyze digital payment transactions, customer behavior, fraud patterns, and risk indicators.

The project demonstrates the complete analytics workflow from raw data preparation and exploratory analysis to advanced SQL investigation and interactive Power BI reporting.
