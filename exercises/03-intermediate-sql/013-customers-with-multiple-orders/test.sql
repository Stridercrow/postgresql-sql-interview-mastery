DO $$
DECLARE
    actual_count INTEGER;
    actual_ids BIGINT[];
    expected_ids BIGINT[] := ARRAY[1];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 1 THEN
        RAISE EXCEPTION 'Expected 1 row, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(customer_id ORDER BY customer_id)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected customer ids %, got %', expected_ids, actual_ids;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Adrian Baker'
          AND order_count <> 3
    ) THEN
        RAISE EXCEPTION 'Adrian Baker should have exactly 3 orders';
    END IF;

    RAISE NOTICE 'PASS - Exercise 013';
END $$;
