-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id, c.name
HAVING SUM(oi.quantity * oi.unit_price) > (
    SELECT AVG(sub.total_spending)
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS total_spending
        FROM orders o2
        JOIN order_items oi2 ON oi2.order_id = o2.id
        GROUP BY o2.customer_id
    ) sub
)
ORDER BY total_spending DESC;
