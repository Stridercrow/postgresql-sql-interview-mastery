DO $$
DECLARE
    result VARCHAR(20);
BEGIN
    -- Test 1: Adrian Baker (spending 4023) → GOLD
    result := classify_customer(1);
    IF result <> 'GOLD' THEN
        RAISE EXCEPTION 'Test 1 failed: expected GOLD, got %', result;
    END IF;

    -- Test 2: Beatriz Garcia (spending 1495) → SILVER
    result := classify_customer(2);
    IF result <> 'SILVER' THEN
        RAISE EXCEPTION 'Test 2 failed: expected SILVER, got %', result;
    END IF;

    -- Test 3: Carlos Hernandez (spending 1475) → SILVER
    result := classify_customer(3);
    IF result <> 'SILVER' THEN
        RAISE EXCEPTION 'Test 3 failed: expected SILVER, got %', result;
    END IF;

    -- Test 4: Diana Lopez (spending 2148) → SILVER
    result := classify_customer(4);
    IF result <> 'SILVER' THEN
        RAISE EXCEPTION 'Test 4 failed: expected SILVER, got %', result;
    END IF;

    -- Test 5: Ethan Brown (spending 38) → BRONZE
    result := classify_customer(5);
    IF result <> 'BRONZE' THEN
        RAISE EXCEPTION 'Test 5 failed: expected BRONZE, got %', result;
    END IF;

    -- Test 6: Customer with no orders → BRONZE
    result := classify_customer(6);
    IF result <> 'BRONZE' THEN
        RAISE EXCEPTION 'Test 6 failed: expected BRONZE, got %', result;
    END IF;

    -- Test 7: Non-existent customer → BRONZE
    result := classify_customer(999);
    IF result <> 'BRONZE' THEN
        RAISE EXCEPTION 'Test 7 failed: expected BRONZE, got %', result;
    END IF;

    RAISE NOTICE 'PASS - Exercise 054';
END $$;
