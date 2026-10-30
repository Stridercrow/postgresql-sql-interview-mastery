DO $$
DECLARE
    v_price NUMERIC(12, 2);
    v_original_price NUMERIC(12, 2);
BEGIN
    -- Save original price of product 1 (ThinkPad, 1450.00)
    SELECT price INTO v_original_price FROM products WHERE id = 1;

    -- Test 1: Successful discount — 20% off 1450.00 = 1160.00
    CALL apply_discount(1, 20);
    SELECT price INTO v_price FROM products WHERE id = 1;
    IF v_price <> 1160.00 THEN
        RAISE EXCEPTION 'Test 1 failed: expected 1160.00, got %', v_price;
    END IF;

    -- Restore price for subsequent tests
    UPDATE products SET price = v_original_price WHERE id = 1;

    -- Test 2: 0% discount — price unchanged
    CALL apply_discount(1, 0);
    SELECT price INTO v_price FROM products WHERE id = 1;
    IF v_price <> 1450.00 THEN
        RAISE EXCEPTION 'Test 2 failed: expected 1450.00, got %', v_price;
    END IF;

    -- Test 3: Non-existent product raises exception
    BEGIN
        CALL apply_discount(999, 10);
        RAISE EXCEPTION 'Test 3 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Product not found%' THEN
                RAISE EXCEPTION 'Test 3 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 4: Inactive product raises exception
    BEGIN
        CALL apply_discount(4, 10);
        RAISE EXCEPTION 'Test 4 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%inactive%' THEN
                RAISE EXCEPTION 'Test 4 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 5: Discount > 50 raises exception
    BEGIN
        CALL apply_discount(1, 60);
        RAISE EXCEPTION 'Test 5 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Discount%' THEN
                RAISE EXCEPTION 'Test 5 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 6: Negative discount raises exception
    BEGIN
        CALL apply_discount(1, -10);
        RAISE EXCEPTION 'Test 6 failed: should have raised an exception';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM NOT LIKE '%Discount%' THEN
                RAISE EXCEPTION 'Test 6 failed: wrong error message, got %', SQLERRM;
            END IF;
    END;

    -- Test 7: Verify product 1 price is still 1450.00 after all failures
    SELECT price INTO v_price FROM products WHERE id = 1;
    IF v_price <> 1450.00 THEN
        RAISE EXCEPTION 'Test 7 failed: product price should still be 1450.00, got %', v_price;
    END IF;

    -- Test 8: Successful 50% discount — 1450.00 → 725.00
    CALL apply_discount(1, 50);
    SELECT price INTO v_price FROM products WHERE id = 1;
    IF v_price <> 725.00 THEN
        RAISE EXCEPTION 'Test 8 failed: expected 725.00, got %', v_price;
    END IF;

    -- Restore price
    UPDATE products SET price = v_original_price WHERE id = 1;

    RAISE NOTICE 'PASS - Exercise 056';
END $$;
