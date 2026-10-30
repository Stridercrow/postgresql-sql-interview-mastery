DO $$
DECLARE
    actual_count INTEGER;
    r RECORD;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    -- Should have exactly 3 customers with completed spending > 1000
    IF actual_count <> 3 THEN
        RAISE EXCEPTION 'Expected 3 rows, got %', actual_count;
    END IF;

    -- 1st: Adrian Baker — 1569 + 1097 = 2666
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Adrian Baker';

    IF r.total_spending <> 2666.00 THEN
        RAISE EXCEPTION 'Adrian Baker spending should be 2666.00, got %', r.total_spending;
    END IF;

    IF r.order_count <> 2 THEN
        RAISE EXCEPTION 'Adrian Baker order_count should be 2, got %', r.order_count;
    END IF;

    -- 2nd: Diana Lopez — 2148
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Diana Lopez';

    IF r.total_spending <> 2148.00 THEN
        RAISE EXCEPTION 'Diana Lopez spending should be 2148.00, got %', r.total_spending;
    END IF;

    -- 3rd: Beatriz Garcia — only order 4 is COMPLETED = 1346
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Beatriz Garcia';

    IF r.total_spending <> 1346.00 THEN
        RAISE EXCEPTION 'Beatriz Garcia spending should be 1346.00, got %', r.total_spending;
    END IF;

    -- Carlos Hernandez (967) should NOT appear (below 1000 threshold)
    IF EXISTS (SELECT 1 FROM exercise_answer WHERE customer_name = 'Carlos Hernandez') THEN
        RAISE EXCEPTION 'Carlos Hernandez should not appear (spending below 1000)';
    END IF;

    -- Ethan Brown (PENDING order only) should NOT appear
    IF EXISTS (SELECT 1 FROM exercise_answer WHERE customer_name = 'Ethan Brown') THEN
        RAISE EXCEPTION 'Ethan Brown should not appear (only PENDING orders)';
    END IF;

    -- Fatima Ali (no orders) should NOT appear
    IF EXISTS (SELECT 1 FROM exercise_answer WHERE customer_name = 'Fatima Ali') THEN
        RAISE EXCEPTION 'Fatima Ali should not appear (no orders)';
    END IF;

    -- Verify ordering: first row should have highest spending
    IF NOT EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE customer_name = 'Adrian Baker'
    ) THEN
        RAISE EXCEPTION 'First row should be Adrian Baker (highest spending)';
    END IF;

    RAISE NOTICE 'PASS - Mock Interview 01';
END $$;
