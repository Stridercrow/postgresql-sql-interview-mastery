CREATE TEMP VIEW exercise_answer AS
WITH ranked_products AS (
    SELECT
        p.category_id,
        cat.name AS category_name,
        p.id AS product_id,
        p.name AS product_name,
        p.price,
        ROW_NUMBER() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS rank_in_category
    FROM products p
    JOIN categories cat ON cat.id = p.category_id
)
SELECT
    category_id,
    category_name,
    product_id,
    product_name,
    price,
    rank_in_category
FROM ranked_products
WHERE rank_in_category <= 2
ORDER BY category_id ASC, price DESC;
