-- Write your procedure here.
-- Do not look at solution.sql until you have attempted the exercise.

CREATE OR REPLACE PROCEDURE process_order(
    p_customer_id  BIGINT,
    p_product_id   BIGINT,
    p_quantity     INTEGER,
    OUT p_order_id BIGINT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_exists BOOLEAN;
    v_product_exists  BOOLEAN;
    v_product_active  BOOLEAN;
    v_price           NUMERIC(12, 2);
    v_stock           INTEGER;
BEGIN
    -- Validate: customer exists
    SELECT EXISTS(SELECT 1 FROM customers WHERE id = p_customer_id)
    INTO v_customer_exists;

    IF NOT v_customer_exists THEN
        RAISE EXCEPTION 'Customer not found';
    END IF;

    -- Validate: product exists
    SELECT EXISTS(SELECT 1 FROM products WHERE id = p_product_id)
    INTO v_product_exists;

    IF NOT v_product_exists THEN
        RAISE EXCEPTION 'Product not found';
    END IF;

    -- Validate: product is active
    SELECT active INTO v_product_active
    FROM products WHERE id = p_product_id;

    IF NOT v_product_active THEN
        RAISE EXCEPTION 'Product is not available';
    END IF;

    -- Validate: quantity is positive
    IF p_quantity <= 0 THEN
        RAISE EXCEPTION 'Quantity must be greater than zero';
    END IF;

    -- Get price and stock
    SELECT price, stock_quantity
    INTO v_price, v_stock
    FROM products WHERE id = p_product_id;

    -- Validate: sufficient stock
    IF v_stock < p_quantity THEN
        RAISE EXCEPTION 'Insufficient stock: available %, requested %', v_stock, p_quantity;
    END IF;

    -- Create the order
    INSERT INTO orders (customer_id, status, created_at)
    VALUES (p_customer_id, 'PENDING', CURRENT_TIMESTAMP)
    RETURNING id INTO p_order_id;

    -- Create the order item
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (p_order_id, p_product_id, p_quantity, v_price);

    -- Decrease stock
    UPDATE products
    SET stock_quantity = stock_quantity - p_quantity
    WHERE id = p_product_id;

    -- Record purchase event
    INSERT INTO product_events (product_id, event_type, payload, created_at)
    VALUES (
        p_product_id,
        'PURCHASED',
        jsonb_build_object(
            'order_id', p_order_id,
            'customer_id', p_customer_id,
            'quantity', p_quantity,
            'unit_price', v_price
        ),
        CURRENT_TIMESTAMP
    );
END;
$$;
