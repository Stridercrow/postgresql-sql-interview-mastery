-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

WITH monthly_spending AS (
    SELECT
        o.customer_id,
        DATE_TRUNC('month', o.created_at) AS month,
        SUM(oi.quantity * oi.unit_price) AS spending
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    GROUP BY o.customer_id, DATE_TRUNC('month', o.created_at)
)
SELECT DISTINCT
    m2.customer_id,
    c.name AS customer_name
FROM monthly_spending m1
JOIN monthly_spending m2
    ON m2.customer_id = m1.customer_id
    AND m2.month = m1.month + INTERVAL '1 month'
JOIN customers c ON c.id = m2.customer_id
WHERE m2.spending > m1.spending
ORDER BY m2.customer_id;
