# ShopNova-E-Commerce-Analytics-Project

ShopNova: E-Commerce Business Analytics Project

Welcome to the ShopNova Business Analytics repository! This project delivers a comprehensive, end-to-end data analytics pipeline and interactive business intelligence framework designed to analyze sales performance, regional customer behaviors, product profit margins, and revenue drivers to optimize ShopNova's quarterly revenues.

**👥 Project Team**

Yash Mundhe

Ashish Raj

Rohit Chauhan

Armaan

Shravani

Vaishnavi

**🎯 Project Objectives**

Sales & Revenue Tracking: Monitor total gross sales, net profit margins, and order volume trends across multiple product lines.

Customer Segmentation: Identify high-value customer groups and analyze lifetime value to optimize retention campaigns.

Product Performance: Evaluate category-wise profitability and inventory turnover rates to prevent costly stockouts.

Regional Expansion: Pinpoint top-performing geographic markets to guide regional marketing and fulfillment strategies.

Seasonal Identification: Analyze order patterns and demand surges during major holiday seasons like Q4 promotional windows.

Automated BI: Establish robust SQL-to-Dashboard pipelines enabling real-time executive decision-making via Power BI and Tableau.

**🛠️ Tools & Technologies Used**

Microsoft Excel: Data analysis, PivotTables, KPIs, and foundational trend examination.

Tableau: Interactive visualizations and deep operational metric breakdowns.

Power BI: Interactive executive dashboards and dynamic KPI performance analysis.

MySQL Workbench: Data querying, schema relational modeling, and strict KPI validation (shopnova_db).

**🎯 Key Performance Indicators (KPIs)**

Category | KPI Name | Description | SQL / Calculation Formula | Source Table |
| :--- | :--- | :--- | :--- | :--- |
| **Financial & Sales** | Total Orders | Total count of unique customer orders placed. | `COUNT(DISTINCT Order_ID)` | `orders` |
| | Gross Merchandise Value (GMV) | Total gross sales value before discounts and taxes. | `SUM(Gross_Amount_INR)` | `orders` |
| | Net Revenue | Total net revenue realized after discounts and deductions. | `SUM(Net_Amount_INR)` | `orders` |
| | Average Order Value (AOV) | Average monetary value generated per order. | `SUM(Final_Amount_INR) / COUNT(DISTINCT Order_ID)` | `orders` |
| | Total Discount Amount | Aggregate monetary value of all discounts applied. | `SUM(Discount_Amount_INR)` | `orders` |
| | Discount Rate (%) | Percentage of gross revenue given away as discounts. | `(SUM(Discount_Amount_INR) / SUM(Gross_Amount_INR)) * 100` | `orders` |
| | Total GST Collected | Aggregate tax amount collected across all orders. | `SUM(GST_Amount_INR)` | `orders` |
| **Product & Inventory** | Total Products Sold | Total physical quantity of items sold. | `SUM(Quantity)` | `orders` |
| | Avg Quantity Per Order | Mean number of items purchased in a single order. | `SUM(Quantity) / COUNT(DISTINCT Order_ID)` | `orders` |
| | Unique Products Ordered | Total count of distinct products that have been purchased. | `COUNT(DISTINCT Product_ID)` | `products` |
| | Revenue by Category | Category-level sales performance breakdown. | `SUM(Gross_Amount_INR) GROUP BY Category` | `orders & products` |
| | Average Product Cost | Mean cost price across product catalog. | `AVG(Cost_Price_INR)` | `products` |
| **Customer & Segmentation** | Total Customers | Total count of distinct active customers placing orders. | `COUNT(DISTINCT Customer_ID)` | `customers` |
| | Customer Segment Revenue | Revenue split across New, Regular, Premium, and VIP tiers. | `SUM(Net_Amount_INR) GROUP BY Segment` | `customers & orders` |
| | Repeat Purchase Rate | Proportion of customers placing multiple orders. | `(Customers with >1 Order / Total Unique Customers) * 100` | `customers & orders` |
| **Operational & Returns** | Total Returned Orders | Count of unique orders impacted by returns. | `COUNT(DISTINCT Order_ID)` | `returns` |
| | Order Return Rate (%) | Percentage of orders returned by customers. | `(COUNT(DISTINCT Returns) / COUNT(DISTINCT Orders)) * 100` | `orders & returns` |
| | Average Delivery Time | Mean transit duration from dispatch to doorstep. | `AVG(Delivery_Date - Order_Date)` | `orders` |
| | Order Fulfillment Rate | Percentage of successfully delivered vs. canceled orders. | `(Delivered Orders / Total Orders) * 100` | `orders` |
| **Marketing & Acquisition** | Total Campaigns | Total active marketing campaigns executed. | `COUNT(*)` | `campaigns` |
| | Average Campaign Budget | Mean allocation per marketing campaign. | `AVG(Budget_INR)` | `campaigns` |
| | Campaigns by Channel | Distribution of campaigns across acquisition channels. | `COUNT(*) GROUP BY Channel` | `campaigns` |
| | Return on Ad Spend (ROAS) | Revenue generated relative to marketing investment. | `Revenue Attributed / Total Channel Spend` | `campaigns & orders` |

**📊 Dashboards & Analytics Architecture**

This project features multi-platform visualization suites:

Power BI Dashboards: Tracks high-level executive KPIs (Net Revenue, GMV, Average Order Value, Cancellation Rate %, Return Rate %) with granular month, category, and payment method filters.

Tableau Dashboards: Focuses on regional operational SLA breaches, return root causes by customer segment, and monthly fulfillment trends.

MySQL Database Scripts: Validates row counts and executes complex KPI queries across products, customers, campaigns, orders, and returns tables.

**💡 Major Business Insights**

Top-Selling Products: A small group of popular products drives most total sales, while a large inventory portion sells rarely.

Cart Abandonment: Many users abandon items before purchase, often triggered right when shipping costs or final checkout steps appear.

Discount Impact: While massive discounts increase order volume, they significantly compress the net profit margin per transaction.

Customer Types: Regular loyal buyers demonstrate distinct purchasing behavior compared to one-time deal-driven shoppers.

Sales Locations: Certain cities and regions generate a much higher density of incoming orders than other geographic zones.

Traffic Sources: Direct visitors and natural organic search users tend to buy more items than users arriving from social media ads.

**📈 Actionable Recommendations**

Focus on Loyal Customers: Reward repeat buyers with special perks instead of relying solely on heavy sitewide discounts that hurt overall profit.

Improve the Checkout Page: Display shipping fees earlier in the shopping journey so customers are not surprised right at the final step.

Manage Stock Better: Keep sufficient inventory of best-selling items in stock to prevent stockouts and missed sales opportunities.

Smart Marketing Spending: Invest more advertising budget into channels and traffic sources that bring in customers who actually convert.

Better Data Habits: Regularly clean and organize data files to keep reports completely accurate as transaction volume scales.

Friendly Follow-ups: Send automated reminder emails or messages to customers who left items in carts to encourage checkout completion.

📂 Repository Structure

ShopNova-Business-Analytics/
│
├── data/                      # Raw and cleaned datasets (CSV, Parquet)
├── notebooks/                 # Jupyter notebooks for exploratory analysis
├── sql/                       # MySQL Workbench scripts and KPI queries
├── dashboards/                # Power BI (.pbix) and Tableau (.twbx) files
└── README.md                  # Project documentation
