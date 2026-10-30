DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 1 THEN
        RAISE EXCEPTION 'Expected 1 row, got %', actual_count;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_id = 2
          AND customer_name = 'Beatriz Garcia'
    ) THEN
        RAISE EXCEPTION 'Beatriz Garcia (customer 2) should be the only result';
    END IF;

    -- Verify Beatriz actually bought all 3 keyboard products
    IF (
        SELECT COUNT(DISTINCT oi.product_id)
        FROM orders o
        JOIN order_items oi ON oi.order_id = o.id
        WHERE o.customer_id = 2
          AND oi.product_id IN (
              SELECT id FROM products WHERE category_id = 3
          )
    ) <> 3 THEN
        RAISE EXCEPTION 'Beatriz should have purchased all 3 keyboard products';
    END IF;

    -- Verify Adrian does NOT qualify (missing product 8)
    IF EXISTS (
        SELECT 1 FROM exercise_answer WHERE customer_id = 1
    ) THEN
        RAISE EXCEPTION 'Adrian Baker should not qualify (missing Keychron Q1)';
    END IF;

    RAISE NOTICE 'PASS - Exercise 017';
END $$;
