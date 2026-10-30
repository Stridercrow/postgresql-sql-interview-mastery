-- Write your procedure here.
-- Do not look at solution.sql until you have attempted the exercise.

CREATE OR REPLACE PROCEDURE apply_discount(
    p_product_id BIGINT,
    p_discount_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_exists   BOOLEAN;
    v_active   BOOLEAN;
    v_price    NUMERIC(12, 2);
    v_new_price NUMERIC(12, 2);
BEGIN
    -- Check product exists
    SELECT EXISTS(SELECT 1 FROM products WHERE id = p_product_id)
    INTO v_exists;

    IF NOT v_exists THEN
        RAISE EXCEPTION 'Product not found';
    END IF;

    -- Check product is active
    SELECT active INTO v_active FROM products WHERE id = p_product_id;

    IF NOT v_active THEN
        RAISE EXCEPTION 'Cannot discount an inactive product';
    END IF;

    -- Validate discount range
    IF p_discount_percent < 0 OR p_discount_percent > 50 THEN
        RAISE EXCEPTION 'Discount must be between 0 and 50';
    END IF;

    -- Calculate new price
    SELECT price INTO v_price FROM products WHERE id = p_product_id;
    v_new_price := v_price - (v_price * p_discount_percent / 100);

    -- Validate minimum price
    IF v_new_price < 1.00 THEN
        RAISE EXCEPTION 'Discounted price would be below minimum';
    END IF;

    -- Apply the discount
    UPDATE products
    SET price = v_new_price
    WHERE id = p_product_id;
END;
$$;
