DO $$
DECLARE
    actual_count INTEGER;
    actual_ids BIGINT[];
    expected_ids BIGINT[] := ARRAY[1, 4];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 2 THEN
        RAISE EXCEPTION 'Expected 2 rows, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(customer_id ORDER BY customer_id)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected customer ids %, got %', expected_ids, actual_ids;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer WHERE customer_name = 'Adrian Baker'
    ) THEN
        RAISE EXCEPTION 'Adrian Baker should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer WHERE customer_name = 'Diana Lopez'
    ) THEN
        RAISE EXCEPTION 'Diana Lopez should be in the result';
    END IF;

    RAISE NOTICE 'PASS - Exercise 016';
END $$;
