DROP PROCEDURE IF EXISTS update_customer_tier(BIGINT);

CREATE PROCEDURE update_customer_tier(p_customer_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total NUMERIC;
    v_tier  VARCHAR(20);
BEGIN
    -- Calculate total spending
    SELECT COALESCE(SUM(oi.quantity * oi.unit_price), 0)
    INTO v_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    WHERE o.customer_id = p_customer_id;

    -- Determine tier
    IF v_total >= 3000 THEN
        v_tier := 'GOLD';
    ELSIF v_total >= 1000 THEN
        v_tier := 'SILVER';
    ELSE
        v_tier := 'BRONZE';
    END IF;

    -- Update the customer
    UPDATE customers
    SET loyalty_tier = v_tier
    WHERE id = p_customer_id;
END;
$$;
