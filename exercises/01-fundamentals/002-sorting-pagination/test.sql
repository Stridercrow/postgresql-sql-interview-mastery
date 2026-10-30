DO $$
DECLARE
    actual_count INTEGER;
    expected_ids BIGINT[] := ARRAY[6, 14, 8, 7, 15];
    actual_ids BIGINT[];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 5 THEN
        RAISE EXCEPTION 'Expected 5 rows, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(id ORDER BY price DESC, id ASC)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected ids %, got %', expected_ids, actual_ids;
    END IF;

    RAISE NOTICE 'PASS - Exercise 002';
END $$;
