CREATE TEMP VIEW exercise_answer AS
SELECT
    id,
    name,
    price
FROM products
WHERE active = TRUE
  AND price > 100
ORDER BY price DESC, id ASC;
