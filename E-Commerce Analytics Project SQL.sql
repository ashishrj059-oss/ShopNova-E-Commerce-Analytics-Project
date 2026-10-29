/*
========================================================
PROJECT: ShopNova E-commerce Analytics
DATABASE: shopnova_db
TOOL: MySQL Workbench

OBJECTIVE:
Analyze e-commerce orders, customers, products,
campaigns, and returns using SQL KPIs.
========================================================
*/
CREATE DATABASE shopnova_db;
USE shopnova_db;
show tables;

-- Check row counts for each table
select 'products' as table_name, count(*) as Total_rows from products
union all
select 'customers', count(*) from customers
union all
select 'campaigns', count(*) from campaigns
union all
select 'orders', count(*) from orders
union all
select 'returns', count(*) from returns;

-- -------------------------------------------------
-- 1. Products
describe products;

-- 2. Customers
describe customers;

-- 3. Campaigns
describe campaigns;

-- 4. Orders
describe orders;

-- 5. Returns
describe returns;

-- ------------------------------------------------------
-- 1. Preview Orders
select * from orders limit 5;

-- 2. Preview Customers
select * from customers limit 5;

-- 3. Preview Products
select * from products limit 5;

-- 4. Preview Campaigns
select * from campaigns limit 5;

-- 5. Preview Returns
select * from returns limit 5;

-- ---------------KPI's LIST---------------------------
-- KPI01 - Total Orders
select count(distinct Order_ID) as Total_Orders 
from orders;

-- KPI02 - Total GMV
select sum(Gross_Amount_INR) as Total_GMV
from orders;

-- KPI03 - Total Customers who placed orders
select count(distinct Customer_ID) as Total_Customers
from customers;

-- KPI04 - Total Products Sold
select sum(Quantity) as Total_Products_Sold
from orders;

-- KPI05 - Average Order Value (AOV)
select sum(Final_Amount_INR)/ count(distinct Order_ID) as Average_Order_Value
from orders;

-- KPI06 - Total Revenue
select round(sum(Net_Amount_INR)) as Total_Net_Revenue
from orders;

-- KPI07 - Total Discount Amount
select Round(sum(Discount_Amount_INR)) as Total_Discount_Amount
from orders;

-- KPI08 - Total GST Collected
select round(sum(GST_Amount_INR)) AS Total_GST_Collected
from orders;

-- KPI09 - Total Final Amount
select round(sum(Final_Amount_INR)) as Total_Final_Amount
from orders;

-- KPI10 - Total Orders with Discount
select count(Order_ID) as Total_Orders_with_Discount
from orders
where Discount_Amount_INR > 0;

-- KPI11 - Discount Rate(%)
select round(sum(Discount_Amount_INR)/nullif(sum(Gross_Amount_INR),0)*100,2) as Discount_Rate_Percent
from orders;

-- KPI12 - Average Discount Per Order
select round(sum(Discount_Amount_INR)/nullif(COUNT(distinct Order_ID),0),2) as Average_Discount_Per_Order
from Orders;

-- KPI13 - Total Orders with GST
select count(DISTINCT Order_ID) as Orders_with_gst
FROM orders
where GST_Amount_INR > 0;

-- KPI14 - Average GST Per Order
SELECT Round(sum(GST_Amount_INR)/NULLIF(COUNT(Order_ID),0),2) as Average_GST_Per_Order
from orders;

-- KPI15 - Total Units Sold
Select sum(Quantity) as Total_Units_Sold
from orders;

-- KPI16 - Average Quantity Per Order
Select Round(Sum(Quantity)/nullif(count(distinct Order_ID),0),2) as Average_Quantity_Per_Order
from orders;

-- KPI17 - Number of Unique Products Ordered
Select count(DISTINCT Product_ID) AS No_of_unique_products_ordered
from products;

-- KPI18 - Top 10 Products by GMV
Select Product_ID,Round(Sum(Gross_Amount_INR),2) as PRODUCT_GMV
from orders
group by Product_ID
Order by Product_GMV Desc
Limit 10;

-- KPI19 - Revenue by Product Category
Select p.category, round(sum(O.Gross_Amount_INR),2) as Category_GMV
FROM orders o join Products p
on o.product_id = p.product_id
group by p.category
order by Category_GMV Desc;

-- KPI20 - Total Returned Orders
select Count(distinct Order_ID) as Total_Returned_Orders
from returns;

-- KPI21 - Total Return Records
select count(distinct Return_ID) as Total_Return_Records
from returns;

-- KPI22 - Order Return Rate (%)
select Round(count(distinct r.Order_ID)*100.0/
nullif(count(distinct o.Order_ID),0),2) AS Return_Rate_Percent
from orders o join returns r
on o.Order_ID = r.Order_ID;

-- KPI23 - Total Campaigns
select count(*) as Total_campaigns
from campaigns;

-- KPI24 - Average Campaign Budget
select round(AVG(Budget_INR),2) as Average_Campaign_Budget
from campaigns;

-- KPI25 - Campaigns by Channel
select channel,count(*) as Campaign_count
from campaigns
group by channel
order by Campaign_count desc;

-- KPI26 - Products by Category
select CATEGORY,COUNT(DISTINCT Product_ID) AS Products_Count
from Products
group by category
order by Products_Count desc;

-- KPI27 - Average Product Price
select round(Avg(Cost_Price_INR),0) as Average_Product_Price
from products;

-- KPI28 - Average Order Quantity
select round(avg(Quantity),0) as Average_Order_Quantity
from orders;

-- KPI29 - Orders by Payment Method
select Payment_Method,count(distinct Order_ID) as Order_Count 
from orders
group by Payment_Method
Order by Order_Count desc;

-- KPI30 - Net Revenue by Product Category
select p.category,round(sum(o.Net_Amount_INR),0) AS Net_Revenue
from products p join orders o
on p.Product_ID = o.Product_ID
group by p.category
order by Net_Revenue desc;

-- KPI 31 - Monthly Order Trend
SELECT DATE_FORMAT(
           STR_TO_DATE(Order_Date, '%Y-%m-%d'),
           '%Y-%m'
       ) AS Order_Month,
       COUNT(DISTINCT Order_ID) AS Total_Orders
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;

-- KPI 32 — Monthly GMV Trend
SELECT DATE_FORMAT(
           STR_TO_DATE(Order_Date, '%Y-%m-%d'),
           '%Y-%m'
       ) AS Order_Month,
       ROUND(SUM(Gross_Amount_INR), 2) AS Monthly_GMV
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;


-- KPI 33 — Gross Margin by Category
SELECT
    p.Category,
    ROUND(SUM(o.Gross_Amount_INR), 2) AS Gross_Sales,
    ROUND(SUM(o.Net_Amount_INR), 2) AS Net_Revenue,
    ROUND(
        SUM(o.Gross_Amount_INR) - SUM(o.Net_Amount_INR),
        2
    ) AS Gross_Margin_Amount,
    ROUND(
        (SUM(o.Gross_Amount_INR) - SUM(o.Net_Amount_INR))
        * 100.0 / NULLIF(SUM(o.Gross_Amount_INR), 0),
        2
    ) AS Gross_Margin_Percent
FROM orders o
JOIN products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Gross_Margin_Percent DESC;


-- KPI 34 — Top 5 Revenue Cities
SELECT
    c.City,
    ROUND(SUM(o.Net_Amount_INR), 2) AS Total_Revenue
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY Total_Revenue DESC
LIMIT 5;


-- KPI 35 — Orders by Channel
SELECT
    Order_Channel,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM orders
GROUP BY Order_Channel
ORDER BY Total_Orders DESC;


-- KPI 36 - Monthly Revenue Trend
SELECT
    DATE_FORMAT(
        STR_TO_DATE(Order_Date, '%Y-%m-%d'),
        '%Y-%m'
    ) AS Order_Month,
    ROUND(SUM(Net_Amount_INR), 2) AS Monthly_Revenue
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;


SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    ROUND(SUM(Gross_Amount_INR), 2) AS Total_GMV,
    ROUND(SUM(Net_Amount_INR), 2) AS Total_Net_Revenue,
    ROUND(SUM(Discount_Amount_INR), 2) AS Total_Discounts,
    ROUND(SUM(GST_Amount_INR), 2) AS Total_GST,
    ROUND(SUM(Final_Amount_INR), 2) AS Total_Final_Amount
FROM orders;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(
        CASE
            WHEN ABS(
                Final_Amount_INR -
                (Net_Amount_INR + GST_Amount_INR)
            ) > 0.01
            THEN 1 ELSE 0
        END
    ) AS Rows_Not_Matching_Net_Plus_GST,
    ROUND(
        SUM(Net_Amount_INR + GST_Amount_INR), 2
    ) AS Expected_Final_Amount
FROM orders;

SELECT
    SUM(
        CASE
            WHEN ABS(Final_Amount_INR - Net_Amount_INR) < 0.01
            THEN 1 ELSE 0
        END
    ) AS Final_Equals_Net_Rows,

    SUM(
        CASE
            WHEN ABS(
                Final_Amount_INR -
                (Net_Amount_INR + GST_Amount_INR)
            ) < 0.01
            THEN 1 ELSE 0
        END
    ) AS Final_Equals_Net_Plus_GST_Rows,

    SUM(
        CASE
            WHEN ABS(
                Net_Amount_INR -
                (Gross_Amount_INR - Discount_Amount_INR)
            ) > 0.01
            THEN 1 ELSE 0
        END
    ) AS Net_Amount_Mismatch_Rows
FROM orders;

SELECT
    ROUND(SUM(Final_Amount_INR), 2) AS Current_Final_Amount,
    ROUND(SUM(Net_Amount_INR + GST_Amount_INR), 2)
        AS Expected_Final_Amount,
    ROUND(SUM(GST_Amount_INR), 2) AS GST_To_Add
FROM orders;

SELECT
    Order_ID,
    Gross_Amount_INR,
    Discount_Amount_INR,
    Net_Amount_INR,
    GST_Amount_INR,
    Final_Amount_INR
FROM orders
LIMIT 10;


SELECT
    COUNT(*) AS Total_Return_Records,
    COUNT(DISTINCT Order_ID) AS Unique_Returned_Orders,
    COUNT(DISTINCT Product_ID) AS Unique_Returned_Products,
    ROUND(SUM(Refund_Amount_INR), 2) AS Total_Refund_Amount
FROM returns;

SELECT
    COUNT(DISTINCT r.Order_ID) AS Returned_Orders,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    ROUND(
        COUNT(DISTINCT r.Order_ID) * 100.0 /
        NULLIF(COUNT(DISTINCT o.Order_ID), 0),
        2
    ) AS Return_Rate_Percent
FROM orders o
LEFT JOIN returns r
    ON o.Order_ID = r.Order_ID;
    
SELECT
    SUM(CASE
        WHEN Order_ID IS NULL OR TRIM(Order_ID) = ''
        THEN 1 ELSE 0
    END) AS Missing_Order_ID,
    SUM(CASE
        WHEN Customer_ID IS NULL OR TRIM(Customer_ID) = ''
        THEN 1 ELSE 0
    END) AS Missing_Customer_ID,
    SUM(CASE
        WHEN Product_ID IS NULL OR TRIM(Product_ID) = ''
        THEN 1 ELSE 0
    END) AS Missing_Product_ID,
    SUM(CASE
        WHEN Order_Date IS NULL OR TRIM(Order_Date) = ''
        THEN 1 ELSE 0
    END) AS Missing_Order_Date
FROM orders;






















