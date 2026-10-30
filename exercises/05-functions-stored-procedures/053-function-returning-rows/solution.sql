DROP FUNCTION IF EXISTS get_category_products(BIGINT);

CREATE FUNCTION get_category_products(p_category_id BIGINT)
RETURNS TABLE (
    product_id     BIGINT,
    product_name   VARCHAR(200),
    price          NUMERIC(12, 2),
    stock_quantity INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id,
        p.name,
        p.price,
        p.stock_quantity
    FROM products p
    WHERE p.category_id = p_category_id
      AND p.active = TRUE
    ORDER BY p.price DESC, p.id ASC;
END;
$$;
