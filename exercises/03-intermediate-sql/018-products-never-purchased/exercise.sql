-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

SELECT
    p.id,
    p.name,
    p.price
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.id
WHERE oi.id IS NULL
ORDER BY p.id;
