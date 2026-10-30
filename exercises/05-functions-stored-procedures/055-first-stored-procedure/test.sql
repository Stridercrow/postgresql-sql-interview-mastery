DO $$
DECLARE
    result VARCHAR(20);
BEGIN
    -- Test 1: Adrian Baker (spending 4023) → GOLD
    CALL update_customer_tier(1);
    SELECT loyalty_tier INTO result FROM customers WHERE id = 1;
    IF result <> 'GOLD' THEN
        RAISE EXCEPTION 'Test 1 failed: expected GOLD, got %', result;
    END IF;

    -- Test 2: Beatriz Garcia (spending 1495) → SILVER
    CALL update_customer_tier(2);
    SELECT loyalty_tier INTO result FROM customers WHERE id = 2;
    IF result <> 'SILVER' THEN
        RAISE EXCEPTION 'Test 2 failed: expected SILVER, got %', result;
    END IF;

    -- Test 3: Ethan Brown (spending 38) → BRONZE
    CALL update_customer_tier(5);
    SELECT loyalty_tier INTO result FROM customers WHERE id = 5;
    IF result <> 'BRONZE' THEN
        RAISE EXCEPTION 'Test 3 failed: expected BRONZE, got %', result;
    END IF;

    -- Test 4: Customer with no orders → BRONZE
    CALL update_customer_tier(6);
    SELECT loyalty_tier INTO result FROM customers WHERE id = 6;
    IF result <> 'BRONZE' THEN
        RAISE EXCEPTION 'Test 4 failed: expected BRONZE, got %', result;
    END IF;

    -- Test 5: Non-existent customer — should not raise an error
    CALL update_customer_tier(999);

    -- Test 6: Diana Lopez (spending 2148) → SILVER
    CALL update_customer_tier(4);
    SELECT loyalty_tier INTO result FROM customers WHERE id = 4;
    IF result <> 'SILVER' THEN
        RAISE EXCEPTION 'Test 6 failed: expected SILVER, got %', result;
    END IF;

    -- Cleanup: reset all loyalty tiers back to seed values
    UPDATE customers SET loyalty_tier = 'GOLD' WHERE id IN (1);
    UPDATE customers SET loyalty_tier = 'SILVER' WHERE id IN (2, 3, 4);
    UPDATE customers SET loyalty_tier = 'BRONZE' WHERE id IN (5, 6, 7, 8, 9, 10);

    RAISE NOTICE 'PASS - Exercise 055';
END $$;
