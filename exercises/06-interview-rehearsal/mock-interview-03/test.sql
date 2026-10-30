DO $$
DECLARE
    actual_count INTEGER;
    r RECORD;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    -- 5 customers have orders
    IF actual_count <> 5 THEN
        RAISE EXCEPTION 'Expected 5 rows, got %', actual_count;
    END IF;

    -- Adrian Baker: 1569 + 1097 + 1357 = 4023, 6 products, HIGH
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Adrian Baker';

    IF r.total_spending <> 4023.00 THEN
        RAISE EXCEPTION 'Adrian: expected spending=4023.00, got %', r.total_spending;
    END IF;

    IF r.distinct_products <> 6 THEN
        RAISE EXCEPTION 'Adrian: expected distinct_products=6, got %', r.distinct_products;
    END IF;

    IF r.spending_tier <> 'HIGH' THEN
        RAISE EXCEPTION 'Adrian: expected tier=HIGH, got %', r.spending_tier;
    END IF;

    -- Diana Lopez: 2148, 3 products, HIGH
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Diana Lopez';

    IF r.total_spending <> 2148.00 THEN
        RAISE EXCEPTION 'Diana: expected spending=2148.00, got %', r.total_spending;
    END IF;

    IF r.distinct_products <> 3 THEN
        RAISE EXCEPTION 'Diana: expected distinct_products=3, got %', r.distinct_products;
    END IF;

    IF r.spending_tier <> 'HIGH' THEN
        RAISE EXCEPTION 'Diana: expected tier=HIGH, got %', r.spending_tier;
    END IF;

    -- Beatriz Garcia: 1346 + 149 = 1495, 5 products, MEDIUM
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Beatriz Garcia';

    IF r.total_spending <> 1495.00 THEN
        RAISE EXCEPTION 'Beatriz: expected spending=1495.00, got %', r.total_spending;
    END IF;

    IF r.distinct_products <> 5 THEN
        RAISE EXCEPTION 'Beatriz: expected distinct_products=5, got %', r.distinct_products;
    END IF;

    IF r.spending_tier <> 'MEDIUM' THEN
        RAISE EXCEPTION 'Beatriz: expected tier=MEDIUM, got %', r.spending_tier;
    END IF;

    -- Carlos Hernandez: 508 + 967 = 1475, 4 products, MEDIUM
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Carlos Hernandez';

    IF r.total_spending <> 1475.00 THEN
        RAISE EXCEPTION 'Carlos: expected spending=1475.00, got %', r.total_spending;
    END IF;

    IF r.distinct_products <> 4 THEN
        RAISE EXCEPTION 'Carlos: expected distinct_products=4, got %', r.distinct_products;
    END IF;

    IF r.spending_tier <> 'MEDIUM' THEN
        RAISE EXCEPTION 'Carlos: expected tier=MEDIUM, got %', r.spending_tier;
    END IF;

    -- Ethan Brown: 38, 1 product, LOW
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Ethan Brown';

    IF r.total_spending <> 38.00 THEN
        RAISE EXCEPTION 'Ethan: expected spending=38.00, got %', r.total_spending;
    END IF;

    IF r.distinct_products <> 1 THEN
        RAISE EXCEPTION 'Ethan: expected distinct_products=1, got %', r.distinct_products;
    END IF;

    IF r.spending_tier <> 'LOW' THEN
        RAISE EXCEPTION 'Ethan: expected tier=LOW, got %', r.spending_tier;
    END IF;

    -- Customers with no orders should NOT appear
    IF EXISTS (SELECT 1 FROM exercise_answer WHERE customer_name = 'Fatima Ali') THEN
        RAISE EXCEPTION 'Fatima Ali should not appear (no orders)';
    END IF;

    -- Verify ordering: Adrian first, Ethan last
    IF EXISTS (
        SELECT 1 FROM exercise_answer
        WHERE customer_name = 'Ethan Brown'
        AND EXISTS (
            SELECT 1 FROM exercise_answer
            WHERE customer_name = 'Adrian Baker'
            AND total_spending < (SELECT total_spending FROM exercise_answer WHERE customer_name = 'Ethan Brown')
        )
    ) THEN
        RAISE EXCEPTION 'Result is not ordered by total_spending DESC';
    END IF;

    RAISE NOTICE 'PASS - Mock Interview 03';
END $$;
