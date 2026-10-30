DO $$
DECLARE
    actual_count INTEGER;
    cat_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 10 THEN
        RAISE EXCEPTION 'Expected 10 rows, got %', actual_count;
    END IF;

    -- Verify each category has exactly 2 products
    FOR cat_count IN
        SELECT COUNT(*) AS cnt
        FROM exercise_answer
        GROUP BY category_id
        ORDER BY category_id
    LOOP
        IF cat_count <> 2 THEN
            RAISE EXCEPTION 'Each category should have exactly 2 products, got %', cat_count;
        END IF;
    END LOOP;

    -- Check Laptops (category 1): ThinkPad and MacBook Air
    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE category_id = 1 AND product_name = 'ThinkPad X1 Carbon' AND rank_in_category = 1
    ) THEN
        RAISE EXCEPTION 'ThinkPad X1 Carbon should be #1 in Laptops';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE category_id = 1 AND product_name = 'MacBook Air' AND rank_in_category = 2
    ) THEN
        RAISE EXCEPTION 'MacBook Air should be #2 in Laptops';
    END IF;

    -- Check Monitors (category 2): Dell UltraSharp and LG 27GP850
    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE category_id = 2 AND product_name = 'Dell UltraSharp 27' AND rank_in_category = 1
    ) THEN
        RAISE EXCEPTION 'Dell UltraSharp 27 should be #1 in Monitors';
    END IF;

    -- Check Networking (category 5): UniFi and TP-Link
    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE category_id = 5 AND product_name = 'UniFi Dream Machine' AND rank_in_category = 1
    ) THEN
        RAISE EXCEPTION 'UniFi Dream Machine should be #1 in Networking';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE category_id = 5 AND product_name = 'TP-Link AX55' AND rank_in_category = 2
    ) THEN
        RAISE EXCEPTION 'TP-Link AX55 should be #2 in Networking';
    END IF;

    -- Verify no budget/cheap products appear
    IF EXISTS (
        SELECT 1 FROM exercise_answer WHERE product_name = 'Basic Keyboard'
    ) THEN
        RAISE EXCEPTION 'Basic Keyboard should not be in the result';
    END IF;

    RAISE NOTICE 'PASS - Exercise 023';
END $$;
