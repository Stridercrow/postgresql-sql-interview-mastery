CREATE TEMP VIEW exercise_answer AS
SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    COUNT(o.id) AS order_count
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(o.id) >= 3
ORDER BY order_count DESC, customer_id ASC;
