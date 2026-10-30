SELECT
    id,
    name,
    price
FROM products
WHERE active = TRUE
ORDER BY price DESC, id ASC
LIMIT 5
OFFSET 5;
