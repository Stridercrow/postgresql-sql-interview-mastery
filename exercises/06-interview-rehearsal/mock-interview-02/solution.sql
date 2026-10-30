CREATE TEMP VIEW exercise_answer AS
WITH monthly_revenue AS (
    SELECT
        TO_CHAR(DATE_TRUNC('month', o.created_at), 'YYYY-MM') AS month,
        cat.name AS category_name,
        SUM(oi.quantity * oi.unit_price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    JOIN products p ON p.id = oi.product_id
    JOIN categories cat ON cat.id = p.category_id
    WHERE o.status IN ('COMPLETED', 'PAID', 'SHIPPED')
    GROUP BY DATE_TRUNC('month', o.created_at), cat.id, cat.name
)
SELECT
    month,
    category_name,
    monthly_revenue,
    RANK() OVER (
        PARTITION BY month
        ORDER BY monthly_revenue DESC
    ) AS rank_in_month
FROM monthly_revenue
ORDER BY month ASC, rank_in_month ASC;
