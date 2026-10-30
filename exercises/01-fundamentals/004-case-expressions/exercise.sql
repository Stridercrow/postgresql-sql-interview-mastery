SELECT
    id,
    name,
    price,
    CASE
        WHEN price < 50 THEN 'CHEAP'
        WHEN price <= 200 THEN 'STANDARD'
        ELSE 'PREMIUM'
    END AS price_band
FROM products
ORDER BY id;
