DO $$
DECLARE
    actual_count INTEGER;
    expected_ids BIGINT[] := ARRAY[3, 5, 6];
    actual_ids BIGINT[];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 3 THEN
        RAISE EXCEPTION 'Expected 3 rows, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(id ORDER BY created_at)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected ids %, got %', expected_ids, actual_ids;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE created_at < TIMESTAMP '2026-02-01'
           OR created_at >= TIMESTAMP '2026-03-01'
    ) THEN
        RAISE EXCEPTION 'Result contains a timestamp outside February 2026';
    END IF;

    RAISE NOTICE 'PASS - Exercise 003';
END $$;
