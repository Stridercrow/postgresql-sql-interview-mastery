DO $$
DECLARE
    result NUMERIC;
BEGIN
    -- Test 1: 10% discount on 100.00 → 90.00
    result := calculate_discount(100.00, 10);
    IF result <> 90.00 THEN
        RAISE EXCEPTION 'Test 1 failed: expected 90.00, got %', result;
    END IF;

    -- Test 2: 20% discount on 250.00 → 200.00
    result := calculate_discount(250.00, 20);
    IF result <> 200.00 THEN
        RAISE EXCEPTION 'Test 2 failed: expected 200.00, got %', result;
    END IF;

    -- Test 3: 0% discount → price unchanged
    result := calculate_discount(50.00, 0);
    IF result <> 50.00 THEN
        RAISE EXCEPTION 'Test 3 failed: expected 50.00, got %', result;
    END IF;

    -- Test 4: 100% discount → 0.00
    result := calculate_discount(50.00, 100);
    IF result <> 0.00 THEN
        RAISE EXCEPTION 'Test 4 failed: expected 0.00, got %', result;
    END IF;

    -- Test 5: Non-round numbers
    result := calculate_discount(333.33, 15);
    IF result <> 283.3305 THEN
        RAISE EXCEPTION 'Test 5 failed: expected 283.3305, got %', result;
    END IF;

    -- Test 6: Function returns NUMERIC
    IF pg_typeof(result) <> 'numeric'::regtype THEN
        RAISE EXCEPTION 'Test 6 failed: return type should be NUMERIC';
    END IF;

    RAISE NOTICE 'PASS - Exercise 051';
END $$;
