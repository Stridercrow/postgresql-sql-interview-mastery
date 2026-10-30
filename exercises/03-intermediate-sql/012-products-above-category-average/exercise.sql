-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

SELECT
    p.id,
    p.name,
    p.price,
    p.category_id
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
)
ORDER BY p.category_id ASC, p.price DESC;
