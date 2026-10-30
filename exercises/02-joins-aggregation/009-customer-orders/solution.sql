CREATE TEMP VIEW exercise_answer AS
SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    o.id AS order_id,
    o.created_at AS order_date,
    o.status
FROM customers c
INNER JOIN orders o
    ON o.customer_id = c.id
ORDER BY c.id ASC, o.created_at ASC, o.id ASC;
