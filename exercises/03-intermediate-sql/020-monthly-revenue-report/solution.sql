CREATE TEMP VIEW exercise_answer AS
SELECT
    DATE_TRUNC('month', o.created_at) AS month,
    COUNT(DISTINCT o.id) AS order_count,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY month;
