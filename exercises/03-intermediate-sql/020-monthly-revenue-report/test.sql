DO $$
DECLARE
    actual_count INTEGER;
    r RECORD;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 3 THEN
        RAISE EXCEPTION 'Expected 3 rows, got %', actual_count;
    END IF;

    -- Check January 2026
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-01-01'::timestamp;

    IF r IS NULL THEN
        RAISE EXCEPTION 'Missing January 2026 row';
    END IF;

    IF r.order_count <> 3 THEN
        RAISE EXCEPTION 'January 2026 should have 3 orders, got %', r.order_count;
    END IF;

    IF r.revenue <> 4012.00 THEN
        RAISE EXCEPTION 'January 2026 revenue should be 4012.00, got %', r.revenue;
    END IF;

    -- Check February 2026
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-02-01'::timestamp;

    IF r IS NULL THEN
        RAISE EXCEPTION 'Missing February 2026 row';
    END IF;

    IF r.order_count <> 3 THEN
        RAISE EXCEPTION 'February 2026 should have 3 orders, got %', r.order_count;
    END IF;

    IF r.revenue <> 2014.00 THEN
        RAISE EXCEPTION 'February 2026 revenue should be 2014.00, got %', r.revenue;
    END IF;

    -- Check March 2026
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-03-01'::timestamp;

    IF r IS NULL THEN
        RAISE EXCEPTION 'Missing March 2026 row';
    END IF;

    IF r.order_count <> 3 THEN
        RAISE EXCEPTION 'March 2026 should have 3 orders, got %', r.order_count;
    END IF;

    IF r.revenue <> 3153.00 THEN
        RAISE EXCEPTION 'March 2026 revenue should be 3153.00, got %', r.revenue;
    END IF;

    RAISE NOTICE 'PASS - Exercise 020';
END $$;
