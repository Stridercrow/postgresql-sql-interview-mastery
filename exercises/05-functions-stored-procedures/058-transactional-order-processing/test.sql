DO $$
DECLARE
    v_order_id      BIGINT;
    v_status        VARCHAR(30);
    v_stock         INTEGER;
    v_order_count   INTEGER;
    v_item_count    INTEGER;
    v_event_count   INTEGER;
    v_item_qty      INTEGER;
    v_item_price    NUMERIC(12, 2);
    v_payload       JSONB;
BEGIN
    -- Record starting counts
    SELECT COUNT(*) INTO v_order_count FROM orders;
    SELECT COUNT(*) INTO v_event_count FROM product_events;

    -- ============================================================
    -- Test 1: Successful order — Adrian Baker buys 2x ThinkPad
    -- ============================================================
    CALL process_order(1, 1, 2, v_order_id);

    -- Verify order was created
    IF v_order_id IS NULL THEN
        RAISE EXCEPTION 'Test 1 failed: order_id should not be NULL';
    END IF;

    SELECT status INTO v_status FROM orders WHERE id = v_order_id;
    IF v_status <> 'PENDING' THEN
        RAISE EXCEPTION 'Test 1 failed: expected PENDING, got %', v_status;
    END IF;

    -- Verify order item
    SELECT quantity, unit_price INTO v_item_qty, v_item_price
    FROM order_items
    WHERE order_id = v_order_id;

    IF v_item_qty <> 2 OR v_item_price <> 1450.00 THEN
        RAISE EXCEPTION 'Test 1 failed: expected qty=2 price=1450.00, got qty=% price=%', v_item_qty, v_item_price;
    END IF;

    -- Verify stock decreased (25 → 23)
    SELECT stock_quantity INTO v_stock FROM products WHERE id = 1;
    IF v_stock <> 23 THEN
        RAISE EXCEPTION 'Test 1 failed: expected stock=23, got %', v_stock;
    END IF;

    -- Verify event recorded
    SELECT payload INTO v_payload
    FROM product_events
    WHERE event_type = 'PURCHASED'
      AND product_id = 1
    ORDER BY id DESC
    LIMIT 1;

    IF (v_payload->>'order_id')::BIGINT <> v_order_id THEN
        RAISE EXCEPTION 'Test 1 failed: event payload order_id mismatch';
    END IF;

    -- ============================================================
    -- Test 2: Invalid customer → no order created
    -- ============================================================
    BEGIN
        CALL process_order(999, 1, 1, v_order_id);
        RAISE EXCEPTION 'Test 2 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Customer not found%' THEN
                RAISE EXCEPTION 'Test 2 failed: wrong error, got %', SQLERRM;
            END IF;
    END;

    -- Verify no new order was created
    IF (SELECT COUNT(*) FROM orders) <> v_order_count + 1 THEN
        RAISE EXCEPTION 'Test 2 failed: no new order should be created';
    END IF;

    -- ============================================================
    -- Test 3: Invalid product → no order created
    -- ============================================================
    BEGIN
        CALL process_order(1, 999, 1, v_order_id);
        RAISE EXCEPTION 'Test 3 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Product not found%' THEN
                RAISE EXCEPTION 'Test 3 failed: wrong error, got %', SQLERRM;
            END IF;
    END;

    -- ============================================================
    -- Test 4: Inactive product → no order created
    -- ============================================================
    BEGIN
        CALL process_order(1, 4, 1, v_order_id);
        RAISE EXCEPTION 'Test 4 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%not available%' THEN
                RAISE EXCEPTION 'Test 4 failed: wrong error, got %', SQLERRM;
            END IF;
    END;

    -- ============================================================
    -- Test 5: Invalid quantity (0) → no order created
    -- ============================================================
    BEGIN
        CALL process_order(1, 1, 0, v_order_id);
        RAISE EXCEPTION 'Test 5 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Quantity%' THEN
                RAISE EXCEPTION 'Test 5 failed: wrong error, got %', SQLERRM;
            END IF;
    END;

    -- ============================================================
    -- Test 6: Insufficient stock → no order, stock unchanged
    -- ============================================================
    SELECT stock_quantity INTO v_stock FROM products WHERE id = 1;

    BEGIN
        CALL process_order(1, 1, 1000, v_order_id);
        RAISE EXCEPTION 'Test 6 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Insufficient stock%' THEN
                RAISE EXCEPTION 'Test 6 failed: wrong error, got %', SQLERRM;
            END IF;
    END;

    -- Verify stock unchanged
    IF (SELECT stock_quantity FROM products WHERE id = 1) <> v_stock THEN
        RAISE EXCEPTION 'Test 6 failed: stock should not change on failure';
    END IF;

    -- Verify no new orders from failed attempts
    IF (SELECT COUNT(*) FROM orders) <> v_order_count + 1 THEN
        RAISE EXCEPTION 'Test 6 failed: failed operations should not create orders';
    END IF;

    -- ============================================================
    -- Test 7: Exactly available stock succeeds
    -- ============================================================
    SELECT stock_quantity INTO v_stock FROM products WHERE id = 1;
    CALL process_order(2, 1, v_stock, v_order_id);

    -- Verify stock is now 0
    IF (SELECT stock_quantity FROM products WHERE id = 1) <> 0 THEN
        RAISE EXCEPTION 'Test 7 failed: stock should be 0 after buying all';
    END IF;

    -- ============================================================
    -- Test 8: Order 1 unit of a cheap product works
    -- ============================================================
    CALL process_order(3, 13, 1, v_order_id);

    SELECT status INTO v_status FROM orders WHERE id = v_order_id;
    IF v_status <> 'PENDING' THEN
        RAISE EXCEPTION 'Test 8 failed: expected PENDING, got %', v_status;
    END IF;

    -- Cleanup: remove test-created orders and their items/events
    DELETE FROM product_events WHERE event_type = 'PURCHASED' AND (payload->>'order_id')::BIGINT > 9;
    DELETE FROM order_items WHERE order_id > 9;
    DELETE FROM orders WHERE id > 9;
    -- Restore stock for product 1 (was 25, bought 2 + rest = 25 total)
    UPDATE products SET stock_quantity = 25 WHERE id = 1;
    -- Restore stock for product 13 (was 80, bought 1)
    UPDATE products SET stock_quantity = 80 WHERE id = 13;

    RAISE NOTICE 'PASS - Exercise 058';
END $$;
