# 🛒 TheLook eCommerce: Geo-Friction & Customer Behavior Analysis

## 📌 Project Overview
This project performs an end-to-end analysis of **TheLook**, a fictitious eCommerce clothing site, using the Google BigQuery public dataset. The goal is to identify logistical "friction" points across different geographical regions and analyze customer purchasing patterns to improve conversion rates and shipping efficiency.

## 🏢 Business Problem
Despite high global traffic, certain regions show high cart abandonment rates and longer-than-average shipping times. This analysis seeks to answer:
1. Which regions experience the most significant shipping delays?
2. Is there a correlation between shipping duration and order cancellation?
3. What are the characteristics of our "High-Value" customer segments?

## 🛠️ Tech Stack & Skills
* **Environment:** Google BigQuery (SQL)
* **SQL Skills:** CTEs, Window Functions (`RANK`, `LEAD/LAG`), Date/Time functions, Advanced Joins, Case Statements.
* **Visualization:** Tableau / Looker Studio (Optional: Insert link if applicable)

## 📊 Data Architecture
The dataset includes tables for `users`, `orders`, `order_items`, `products`, and `distribution_centers`. 
*(Note: I recommend creating an ERD at dbdiagram.io and inserting the image here.)*

---

## 🔍 Key Business Questions & SQL Implementation

### 1. Geographical Shipping Performance
* **Question:** Which countries have the highest average lead time (ordered to shipped)?
* **SQL Focus:** `TIMESTAMP_DIFF`, `AVG()`, `GROUP BY`.

### 2. Order Cancellation vs. Delivery Time
* **Question:** Does a delay in shipping increase the likelihood of order cancellation?
* **SQL Focus:** Correlation analysis using `CASE WHEN` and `RATIO` calculations.

### 3. Customer Lifetime Value (CLV) by Region
* **Question:** Which 5 countries generate the highest total revenue per user?
* **SQL Focus:** Window Functions to rank countries by average spend per user.

### 4. Product Category Trends
* **Question:** What are the top 3 best-selling product categories in our fastest-growing regions?
* **SQL Focus:** Subqueries and `RANK() OVER(PARTITION BY...)`.

### 5. Inventory Turnover Gap
* **Question:** Identify products that have been in stock for over 60 days without a sale.
* **SQL Focus:** Filtering with `DATE_SUB` and `NOT EXISTS` or `LEFT JOIN` on orders.

---

## 💡 Executive Summary of Insights (Sample)
* **Insight 1:** Orders from Brazil experience a 25% longer shipping delay compared to the global average, leading to a 10% higher cancellation rate.
* **Insight 2:** The "Championship" customer segment (top 5%) contributes to 42% of the total revenue but has the lowest discount sensitivity.

## 🚀 Recommendations
* **Logistics:** Establish a secondary distribution hub in South America to reduce "Geo-Friction."
* **Marketing:** Re-allocate ad spend from low-conversion regions to high-CLV regions identified in the analysis.

---
## 📫 Contact
* **Name:** Jihye Jay Park
* **Email:** databyjpark@gmail.com
* **LinkedIn:** [Your Profile Link]