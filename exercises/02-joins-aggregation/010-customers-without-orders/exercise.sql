SELECT
    c.id AS customer_id,
    c.name AS customer_name
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.id
WHERE o.id IS NULL
ORDER BY c.id;
