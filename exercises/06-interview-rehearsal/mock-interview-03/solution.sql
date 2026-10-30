-- Part 1: SQL query for customer report
CREATE TEMP VIEW exercise_answer AS
SELECT
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending,
    COUNT(DISTINCT oi.product_id) AS distinct_products,
    MAX(o.created_at) AS last_order_date,
    CASE
        WHEN SUM(oi.quantity * oi.unit_price) > 2000 THEN 'HIGH'
        WHEN SUM(oi.quantity * oi.unit_price) > 500  THEN 'MEDIUM'
        ELSE 'LOW'
    END AS spending_tier
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id, c.name
ORDER BY total_spending DESC;
