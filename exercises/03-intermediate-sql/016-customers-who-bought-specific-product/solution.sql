CREATE TEMP VIEW exercise_answer AS
SELECT
    c.id AS customer_id,
    c.name AS customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    WHERE o.customer_id = c.id
      AND oi.product_id = 1
)
ORDER BY c.id;
