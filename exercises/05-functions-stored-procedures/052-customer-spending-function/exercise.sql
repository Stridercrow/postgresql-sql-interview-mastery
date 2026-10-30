-- Write your function here.
-- Do not look at solution.sql until you have attempted the exercise.

CREATE OR REPLACE FUNCTION get_customer_spending(p_customer_id BIGINT)
RETURNS NUMERIC
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

    RETURN v_total;
END;
$$;
