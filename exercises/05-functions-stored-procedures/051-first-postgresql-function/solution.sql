DROP FUNCTION IF EXISTS calculate_discount(NUMERIC, NUMERIC);

CREATE FUNCTION calculate_discount(
    p_price NUMERIC,
    p_discount_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN p_price - (p_price * p_discount_percent / 100);
END;
$$;
