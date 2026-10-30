DO $$
DECLARE
    v_count INTEGER;
    r RECORD;
BEGIN
    -- Test 1: Category 1 (Laptops) — 3 active products
    SELECT COUNT(*) INTO v_count FROM get_category_products(1);
    IF v_count <> 3 THEN
        RAISE EXCEPTION 'Test 1 failed: expected 3 active laptops, got %', v_count;
    END IF;

    -- Test 2: First product in category 1 should be ThinkPad (highest price)
    SELECT * INTO r FROM get_category_products(1) LIMIT 1;
    IF r.product_id <> 1 OR r.product_name <> 'ThinkPad X1 Carbon' THEN
        RAISE EXCEPTION 'Test 2 failed: expected ThinkPad X1 Carbon first, got %', r.product_name;
    END IF;

    -- Test 3: Old Business Laptop (inactive) should NOT appear
    IF EXISTS (SELECT 1 FROM get_category_products(1) WHERE product_name = 'Old Business Laptop') THEN
        RAISE EXCEPTION 'Test 3 failed: inactive product should not appear';
    END IF;

    -- Test 4: Category 5 (Networking) — 2 active products (Old Router is inactive)
    SELECT COUNT(*) INTO v_count FROM get_category_products(5);
    IF v_count <> 2 THEN
        RAISE EXCEPTION 'Test 4 failed: expected 2 active networking products, got %', v_count;
    END IF;

    -- Test 5: Non-existent category returns 0 rows
    SELECT COUNT(*) INTO v_count FROM get_category_products(999);
    IF v_count <> 0 THEN
        RAISE EXCEPTION 'Test 5 failed: expected 0 rows for non-existent category, got %', v_count;
    END IF;

    -- Test 6: Verify ordering — category 2 should be Dell UltraSharp first, then LG, then Budget
    SELECT * INTO r FROM get_category_products(2) LIMIT 1;
    IF r.product_name <> 'Dell UltraSharp 27' THEN
        RAISE EXCEPTION 'Test 6 failed: expected Dell UltraSharp 27 first in category 2, got %', r.product_name;
    END IF;

    -- Test 7: Verify stock_quantity is returned
    SELECT * INTO r FROM get_category_products(1) WHERE product_name = 'MacBook Air';
    IF r.stock_quantity IS NULL THEN
        RAISE EXCEPTION 'Test 7 failed: stock_quantity should not be NULL';
    END IF;

    RAISE NOTICE 'PASS - Exercise 053';
END $$;
