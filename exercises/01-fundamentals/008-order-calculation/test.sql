DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 9 THEN
        RAISE EXCEPTION 'Expected 9 rows, got %', actual_count;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer a
        JOIN (
            VALUES
                (1::BIGINT, 1569.00::NUMERIC),
                (2::BIGINT, 1097.00::NUMERIC),
                (3::BIGINT, 1357.00::NUMERIC),
                (4::BIGINT, 1346.00::NUMERIC),
                (5::BIGINT, 149.00::NUMERIC),
                (6::BIGINT, 508.00::NUMERIC),
                (7::BIGINT, 967.00::NUMERIC),
                (8::BIGINT, 2148.00::NUMERIC),
                (9::BIGINT, 38.00::NUMERIC)
        ) expected(order_id, order_total)
        USING (order_id)
        WHERE a.order_total <> expected.order_total
    ) THEN
        RAISE EXCEPTION 'At least one order total is incorrect';
    END IF;

    RAISE NOTICE 'PASS - Exercise 008';
END $$;
