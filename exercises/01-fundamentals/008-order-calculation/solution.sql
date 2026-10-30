CREATE TEMP VIEW exercise_answer AS
SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_id;
