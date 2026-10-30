DROP PROCEDURE IF EXISTS cancel_order(BIGINT);

CREATE PROCEDURE cancel_order(p_order_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status     VARCHAR(30);
    v_product_id BIGINT;
BEGIN
    -- Validate: order exists and get status
    SELECT status INTO v_status
    FROM orders
    WHERE id = p_order_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order not found';
    END IF;

    -- Validate: not already cancelled
    IF v_status = 'CANCELLED' THEN
        RAISE EXCEPTION 'Order is already cancelled';
    END IF;

    -- Validate: order is cancellable
    IF v_status NOT IN ('PENDING', 'PAID') THEN
        RAISE EXCEPTION 'Order in status % cannot be cancelled', v_status;
    END IF;

    -- Update order status
    UPDATE orders
    SET status = 'CANCELLED'
    WHERE id = p_order_id;

    -- Get first product from order items (fallback to 0)
    SELECT COALESCE(MIN(product_id), 0)
    INTO v_product_id
    FROM order_items
    WHERE order_id = p_order_id;

    -- Record cancellation event
    INSERT INTO product_events (product_id, event_type, payload, created_at)
    VALUES (
        v_product_id,
        'ORDER_CANCELLED',
        jsonb_build_object('order_id', p_order_id, 'reason', 'customer_request'),
        CURRENT_TIMESTAMP
    );
END;
$$;
