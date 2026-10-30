DROP FUNCTION IF EXISTS classify_customer(BIGINT);

CREATE FUNCTION classify_customer(p_customer_id BIGINT)
RETURNS VARCHAR(20)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(oi.quantity * oi.unit_price), 0)
    INTO v_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    WHERE o.customer_id = p_customer_id;

    IF v_total >= 3000 THEN
        RETURN 'GOLD';
    ELSIF v_total >= 1000 THEN
        RETURN 'SILVER';
    ELSE
        RETURN 'BRONZE';
    END IF;
END;
$$;
