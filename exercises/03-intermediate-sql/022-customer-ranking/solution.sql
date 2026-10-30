CREATE TEMP VIEW exercise_answer AS
WITH customer_spending AS (
    SELECT
        c.id AS customer_id,
        c.name AS customer_name,
        COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spending
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.id
    LEFT JOIN order_items oi ON oi.order_id = o.id
    GROUP BY c.id, c.name
)
SELECT
    customer_id,
    customer_name,
    total_spending,
    ROW_NUMBER() OVER (ORDER BY total_spending DESC, customer_id ASC) AS row_num,
    RANK() OVER (ORDER BY total_spending DESC, customer_id ASC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY total_spending DESC, customer_id ASC) AS dense_rank_num
FROM customer_spending
ORDER BY total_spending DESC, customer_id ASC;
