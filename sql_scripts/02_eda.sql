SELECT 
    country, 
    COUNT(*) as user_count
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE email NOT LIKE '%@example.com%' -- 테스트 계정 제외
GROUP BY country
ORDER BY user_count DESC;

-- Checking the distribution of orders by user country
SELECT 
    u.country, 
    COUNT(o.order_id) as total_orders
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
JOIN `bigquery-public-data.thelook_ecommerce.users` AS u 
  ON o.user_id = u.id
GROUP BY country
ORDER BY total_orders DESC;