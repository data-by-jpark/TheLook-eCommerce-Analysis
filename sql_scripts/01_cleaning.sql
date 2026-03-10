/*
PROJECT: TheLook eCommerce Analysis
FILE: 01_cleaning.sql
PURPOSE: Auditing data quality and preparing a clean dataset for EDA.
AUTHOR: Jay Park
DATE: 2026-03-10
*/

-- 1. [CHECK] Duplicate order_id validation
SELECT 
    order_id, 
    COUNT(*) as duplicate_count
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY order_id
HAVING duplicate_count > 1;
-- [RESULT] 0 duplicates found. order_id is a unique primary key.

-- 2. [CHECK] Null delivery dates vs. Order status logic
SELECT 
    status,
    COUNT(*) as total_orders,
    COUNTIF(delivered_at IS NULL) as null_delivery_count
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status;
-- [RESULT] Logic Consistency Check:
-- 1. 'Complete' & 'Returned' status: 0 nulls (100% data integrity for delivery dates).
-- 2. 'Cancelled', 'Processing', 'Shipped': Null counts match total orders.
-- This confirms the delivery timestamp logic is perfectly aligned with order status.

-- 3. [CHECK] Order status distribution for scope definition
SELECT 
    status, 
    COUNT(*) as count,
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status;
-- [RESULT] Shipped (29.9%) and Complete (25.0%) dominate the dataset.
-- [ACTION] Use 'Complete' status for final conversion/net revenue metrics.

-- 4. [CHECK] Illogical date sequences (Timeline audit)
SELECT 
    id AS order_item_id,
    created_at,
    shipped_at,
    delivered_at
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE shipped_at < created_at 
   OR delivered_at < shipped_at;
-- [RESULT] 35,876 anomalies (~20%). Likely synthetic data artifacts.
-- [ACTION] Exclude these records during 'Lead Time' calculations to prevent negative duration.

-- 5. [CHECK] Invalid sale prices (Financial audit)
SELECT 
    id, 
    sale_price,
    product_id
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE sale_price <= 0;
-- [RESULT] 0 records found. All items have valid positive pricing.

-- 6. [CHECK] Profitability audit (Sale Price vs. Cost)
SELECT 
    oi.id AS order_item_id,
    oi.sale_price,
    p.cost,
    (oi.sale_price - p.cost) AS margin
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p 
  ON oi.product_id = p.id
WHERE oi.sale_price < p.cost;
-- [RESULT] 0 records found. No loss-leader or erroneous pricing detected.

-- 7. [CHECK] Geographical data completeness
SELECT 
    id, 
    country, 
    latitude, 
    longitude
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE country IS NULL 
   OR latitude IS NULL 
   OR longitude IS NULL;
-- [RESULT] 0 nulls. 100% data density for geo-friction analysis.

-- 8. [CHECK] Referential Integrity: Orders without matching Users
SELECT 
    COUNT(o.order_id) AS orphaned_orders
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
LEFT JOIN `bigquery-public-data.thelook_ecommerce.users` AS u ON o.user_id = u.id
WHERE u.id IS NULL;
-- [RESULT] 0 orphaned orders found. All transactions are correctly mapped to registered users.