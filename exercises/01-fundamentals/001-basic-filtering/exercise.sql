-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

SELECT
    id,
    name,
    price
FROM products
WHERE active = TRUE
  AND price > 100
ORDER BY price DESC, id ASC;
