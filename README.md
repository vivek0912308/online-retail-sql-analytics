# Online Retail SQL Analytics

## 📌 Project Overview

This repository contains an end-to-end SQL analytics project using a real retail dataset sourced from Kaggle.  
The goal is to clean, transform, and analyze the data using PostgreSQL and derive meaningful business insights.

**Dataset Source:**  
🔗 https://www.kaggle.com/datasets/thedevastator/online-retail-transaction-data

---

## 🧹 Data Cleaning & Preparation

The following data cleaning steps were performed:

- Handled mixed date formats (slashes and dashes) using `CASE` expressions
- Converted `InvoiceDate` text into proper `TIMESTAMP`
- Removed:
  - Returns (negative quantity)
  - Cancelled invoices
  - Transactions with zero or negative prices
  - NULL `CustomerID` values
- Calculated a new column `revenue = Quantity × UnitPrice`

---

## 🛠 Tools Used

- PostgreSQL (for database and analysis)
- SQL (aggregations, filters, date functions, CASE statements)
- GitHub (for version control and documentation)

---

## 📊 Key Performance Indicators (KPIs)

The following KPIs were calculated from the cleaned dataset:

- **Total Revenue:** 8,911,407.90  
- **Total Orders:** 18,532  
- **Total Customers:** 4,338  
- **Average Order Value (AOV):** 480.87  
- **Average Revenue per Customer:** 2,054.21  
- **Return Rate:** Approximately 1.96%

---

## 📈 Business Insights

From the analysis:

- Revenue shows strong **seasonal growth**, especially in Q4 (Sep–Nov).
- **November 2011** had the highest revenue (~1.16M).
- **February 2011** recorded the lowest sales.
- Customers place an average of ~4 orders, indicating repeat buying behavior.
- Contribution from different countries can be compared (e.g., UK historically highest).

---

## 📄 What to Find in This Repo

| File | Description |
|------|-------------|
| `retail_analysis.sql` | SQL script containing all queries used for cleaning and analysis |
| `README.md` | Project documentation and insights |

---

## 🧪 How to Run This (Optional)

1. Create a PostgreSQL database
2. Import the original dataset CSV into a table named `online_retail`
3. Run the SQL script `retail_analysis.sql` step by step
4. View results of each query for insights

---

## ❓ Questions or Feedback

Feel free to open an issue if you have suggestions or questions!
