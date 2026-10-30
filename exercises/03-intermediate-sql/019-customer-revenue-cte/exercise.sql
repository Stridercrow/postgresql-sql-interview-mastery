-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

WITH customer_revenue AS (
    SELECT
        c.id AS customer_id,
        c.name AS customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM customers c
    JOIN orders o ON o.customer_id = c.id
    JOIN order_items oi ON oi.order_id = o.id
    GROUP BY c.id, c.name
)
SELECT
    customer_id,
    customer_name,
    total_revenue
FROM customer_revenue
WHERE total_revenue > 1000
ORDER BY total_revenue DESC;
