SELECT
    id,
    name,
    country,
    COALESCE(country, 'Unknown') AS country_display
FROM customers
ORDER BY id;
