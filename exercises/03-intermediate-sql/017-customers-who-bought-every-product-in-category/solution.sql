CREATE TEMP VIEW exercise_answer AS
SELECT
    c.id AS customer_id,
    c.name AS customer_name
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id
WHERE p.category_id = 3
GROUP BY c.id, c.name
HAVING COUNT(DISTINCT p.id) = (
    SELECT COUNT(*)
    FROM products
    WHERE category_id = 3
)
ORDER BY c.id;
