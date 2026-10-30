DO $$
DECLARE
    actual_count INTEGER;
    actual_ids BIGINT[];
    expected_ids BIGINT[] := ARRAY[4, 16];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 2 THEN
        RAISE EXCEPTION 'Expected 2 rows, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(id ORDER BY id)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected product ids %, got %', expected_ids, actual_ids;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer WHERE name = 'Old Business Laptop'
    ) THEN
        RAISE EXCEPTION 'Old Business Laptop should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer WHERE name = 'Old Router'
    ) THEN
        RAISE EXCEPTION 'Old Router should be in the result';
    END IF;

    -- Verify no purchased products appear
    IF EXISTS (
        SELECT 1
        FROM exercise_answer a
        WHERE EXISTS (
            SELECT 1 FROM order_items oi WHERE oi.product_id = a.id
        )
    ) THEN
        RAISE EXCEPTION 'Result contains a product that has been purchased';
    END IF;

    RAISE NOTICE 'PASS - Exercise 018';
END $$;
