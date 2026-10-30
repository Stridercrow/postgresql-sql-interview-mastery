CREATE TEMP VIEW exercise_answer AS
SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    COUNT(DISTINCT o.id) AS order_count,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent,
    CASE
        WHEN COUNT(DISTINCT o.id) > 0
        THEN SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.id)
        ELSE NULL
    END AS avg_order_value
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id, c.name
ORDER BY c.id;
