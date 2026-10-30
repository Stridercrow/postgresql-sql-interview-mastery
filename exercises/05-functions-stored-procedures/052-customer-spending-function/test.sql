DO $$
DECLARE
    result NUMERIC;
BEGIN
    -- Test 1: Adrian Baker (customer 1) — 3 orders
    result := get_customer_spending(1);
    IF result <> 4023.00 THEN
        RAISE EXCEPTION 'Test 1 failed: expected 4023.00, got %', result;
    END IF;

    -- Test 2: Beatriz Garcia (customer 2)
    result := get_customer_spending(2);
    IF result <> 1495.00 THEN
        RAISE EXCEPTION 'Test 2 failed: expected 1495.00, got %', result;
    END IF;

    -- Test 3: Diana Lopez (customer 4) — single large order
    result := get_customer_spending(4);
    IF result <> 2148.00 THEN
        RAISE EXCEPTION 'Test 3 failed: expected 2148.00, got %', result;
    END IF;

    -- Test 4: Ethan Brown (customer 5) — small order
    result := get_customer_spending(5);
    IF result <> 38.00 THEN
        RAISE EXCEPTION 'Test 4 failed: expected 38.00, got %', result;
    END IF;

    -- Test 5: Customer with no orders returns 0
    result := get_customer_spending(6);
    IF result <> 0 THEN
        RAISE EXCEPTION 'Test 5 failed: expected 0, got %', result;
    END IF;

    -- Test 6: Non-existent customer returns 0
    result := get_customer_spending(999);
    IF result <> 0 THEN
        RAISE EXCEPTION 'Test 6 failed: expected 0, got %', result;
    END IF;

    -- Test 7: All customers with orders have positive spending
    IF get_customer_spending(3) <= 0 THEN
        RAISE EXCEPTION 'Test 7 failed: customer 3 should have positive spending';
    END IF;

    RAISE NOTICE 'PASS - Exercise 052';
END $$;
