CREATE TEMP VIEW exercise_answer AS
SELECT
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending,
    COUNT(DISTINCT o.id) AS order_count,
    MAX(o.created_at) AS last_order_date
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status = 'COMPLETED'
GROUP BY c.id, c.name
HAVING SUM(oi.quantity * oi.unit_price) > 1000
ORDER BY total_spending DESC, c.name ASC;
