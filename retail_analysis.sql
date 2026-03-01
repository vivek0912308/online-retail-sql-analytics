CREATE TABLE online_retail(
InvoiceNo VARCHAR(20),
StockCode VARCHAR(20),
Description TEXT,
Quantity INTEGER,
InvoiceDate TEXT,
UnitPrice NUMERIC(10,2),
CustomerID BIGINT,
Country VARCHAR(50)
);



SELECT COUNT(*) FROM online_retail;


SELECT * FROM online_retail;



SELECT COUNT(*)
FROM online_retail
WHERE online_retail.customerid IS NULL;


SELECT 
COUNT(*) FILTER(WHERE InvoiceNo IS NULL) AS null_invoiceno,
COUNT(*) FILTER(WHERE StockCode IS NULL) AS null_stockcode,
COUNT(*) FILTER(WHERE Description IS NULL) AS null_description,
COUNT(*) FILTER(WHERE Quantity IS NULL) AS null_quantity,
COUNT(*) FILTER(WHERE InvoiceDate IS NULL) AS null_invoicedate,
COUNT(*) FILTER(WHERE UnitPrice IS NULL) AS null_unitprice,
COUNT(*) FILTER(WHERE CustomerID IS NULL) AS null_customerid,
COUNT(*) FILTER(WHERE Country IS NULL) AS null_country
FROM online_retail;



SELECT COUNT(*)
FROM  online_retail
WHERE Quantity<0;


SELECT COUNT(*)
FROM  online_retail
WHERE UnitPrice<=0;


SELECT COUNT(*)
FROM  online_retail
WHERE InvoiceNo LIKE 'C%';


/* CREATE CLEAN TABLE WITH DATE FIX + FILTERING */

CREATE TABLE online_retail_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    /* Handle two date formats */
    CASE 
        WHEN InvoiceDate LIKE '%/%' 
            THEN TO_TIMESTAMP(InvoiceDate, 'MM/DD/YYYY HH24:MI')
        ELSE 
            TO_TIMESTAMP(InvoiceDate, 'YYYY-MM-DD HH24:MI:SS')
    END AS InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    (Quantity * UnitPrice) AS revenue
FROM online_retail
WHERE Quantity > 0
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL
  AND InvoiceNo NOT LIKE 'C%';



/* VERIFY CLEAN ROW COUNT */
SELECT COUNT(*)
FROM online_retail_clean;



/* CORE KPIs */


-- Total Revenue
SELECT ROUND(SUM(revenue),2) AS total_revenue
FROM online_retail_clean;


-- Total Orders
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail_clean;


-- Total Customers
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM online_retail_clean;


-- Average Order Value
SELECT 
ROUND(
    SUM(revenue) / COUNT(DISTINCT InvoiceNo),2) AS avg_order_value
FROM online_retail_clean;

-- Average Revenue Per Customer
SELECT 
ROUND(
    SUM(revenue) / COUNT(DISTINCT CustomerID),2) AS avg_revenue_per_customer
FROM online_retail_clean;


/*MONTHLY REVENUE TREND */
SELECT 
    DATE_TRUNC('month', InvoiceDate) AS month,
    ROUND(SUM(revenue),2) AS monthly_revenue
FROM online_retail_clean
GROUP BY month
ORDER BY month;


/* REVENUE BY COUNTRY */
SELECT 
    Country,
    ROUND(SUM(revenue),2) AS total_revenue
FROM online_retail_clean
GROUP BY Country
ORDER BY total_revenue DESC;


/* TOP 10 CUSTOMERS */
SELECT 
    CustomerID,
    ROUND(SUM(revenue),2) AS total_spent
FROM online_retail_clean
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;


/* TOP 10 PRODUCTS */
SELECT 
    Description,
    SUM(Quantity) AS total_quantity_sold
FROM online_retail_clean
GROUP BY Description
ORDER BY total_quantity_sold DESC
LIMIT 10;


/*  RETURN RATE (RAW TABLE) */
SELECT 
ROUND(
    (COUNT(*) FILTER (WHERE Quantity < 0)::numeric 
    / COUNT(*)) * 100,2) AS return_percentage
FROM online_retail;
