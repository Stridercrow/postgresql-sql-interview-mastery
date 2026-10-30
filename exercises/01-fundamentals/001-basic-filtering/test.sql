DO $$
DECLARE
    actual_count INTEGER;
    expected_count INTEGER := 10;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> expected_count THEN
        RAISE EXCEPTION 'Expected % rows, got %', expected_count, actual_count;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE NOT (price > 100)
           OR price IS NULL
    ) THEN
        RAISE EXCEPTION 'Result contains a product that does not satisfy price > 100';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer p
        JOIN products real USING (id)
        WHERE real.active IS NOT TRUE
    ) THEN
        RAISE EXCEPTION 'Result contains an inactive product';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer a
        JOIN exercise_answer b
          ON a.id <> b.id
         AND (
             a.price < b.price
             OR (a.price = b.price AND a.id > b.id)
         )
    ) THEN
        RAISE EXCEPTION 'Result is not ordered by price DESC, id ASC';
    END IF;

    RAISE NOTICE 'PASS - Exercise 001';
END $$;
