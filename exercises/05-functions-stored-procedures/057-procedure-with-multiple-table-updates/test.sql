DO $$
DECLARE
    v_status    VARCHAR(30);
    v_count     INTEGER;
    v_event_id  BIGINT;
    v_payload   JSONB;
BEGIN
    -- Record starting event count
    SELECT COUNT(*) INTO v_count FROM product_events;

    -- Test 1: Cancel order 9 (PENDING) — should succeed
    CALL cancel_order(9);

    SELECT status INTO v_status FROM orders WHERE id = 9;
    IF v_status <> 'CANCELLED' THEN
        RAISE EXCEPTION 'Test 1 failed: order 9 should be CANCELLED, got %', v_status;
    END IF;

    -- Verify event was created
    IF (SELECT COUNT(*) FROM product_events) <> v_count + 1 THEN
        RAISE EXCEPTION 'Test 1 failed: expected one new event';
    END IF;

    -- Verify event details
    SELECT id, payload INTO v_event_id, v_payload
    FROM product_events
    WHERE event_type = 'ORDER_CANCELLED'
    ORDER BY id DESC
    LIMIT 1;

    IF (v_payload->>'order_id')::BIGINT <> 9 THEN
        RAISE EXCEPTION 'Test 1 failed: event payload order_id should be 9';
    END IF;

    -- Test 2: Non-existent order raises exception
    BEGIN
        CALL cancel_order(999);
        RAISE EXCEPTION 'Test 2 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Order not found%' THEN
                RAISE EXCEPTION 'Test 2 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 3: Already cancelled order raises exception
    BEGIN
        CALL cancel_order(9);
        RAISE EXCEPTION 'Test 3 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%already cancelled%' THEN
                RAISE EXCEPTION 'Test 3 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 4: Non-cancellable order (SHIPPED) raises exception
    -- Order 3 is SHIPPED
    BEGIN
        CALL cancel_order(3);
        RAISE EXCEPTION 'Test 4 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%cannot be cancelled%' THEN
                RAISE EXCEPTION 'Test 4 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Verify order 3 was NOT modified
    SELECT status INTO v_status FROM orders WHERE id = 3;
    IF v_status <> 'SHIPPED' THEN
        RAISE EXCEPTION 'Test 4 failed: order 3 should still be SHIPPED, got %', v_status;
    END IF;

    -- Test 5: COMPLETED order cannot be cancelled
    BEGIN
        CALL cancel_order(1);
        RAISE EXCEPTION 'Test 5 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%cannot be cancelled%' THEN
                RAISE EXCEPTION 'Test 5 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 6: No new events were created by failed operations
    IF (SELECT COUNT(*) FROM product_events) <> v_count + 1 THEN
        RAISE EXCEPTION 'Test 6 failed: failed operations should not create events';
    END IF;

    -- Cleanup: restore order 9 and remove test events
    UPDATE orders SET status = 'PENDING' WHERE id = 9;
    DELETE FROM product_events WHERE event_type = 'ORDER_CANCELLED' AND (payload->>'order_id')::BIGINT = 9;

    RAISE NOTICE 'PASS - Exercise 057';
END $$;
