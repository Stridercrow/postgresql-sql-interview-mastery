DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 7 THEN
        RAISE EXCEPTION 'Expected 7 rows, got %', actual_count;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer a
        WHERE a.price <= (
            SELECT AVG(p.price)
            FROM products p
            WHERE p.category_id = a.category_id
        )
    ) THEN
        RAISE EXCEPTION 'At least one result does not exceed its category average';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer WHERE id = 1
    ) THEN
        RAISE EXCEPTION 'ThinkPad X1 Carbon should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer WHERE id = 14
    ) THEN
        RAISE EXCEPTION 'UniFi Dream Machine should be in the result';
    END IF;

    IF EXISTS (
        SELECT 1 FROM exercise_answer WHERE id = 4
    ) THEN
        RAISE EXCEPTION 'Old Business Laptop should not be in the result';
    END IF;

    RAISE NOTICE 'PASS - Exercise 012';
END $$;
