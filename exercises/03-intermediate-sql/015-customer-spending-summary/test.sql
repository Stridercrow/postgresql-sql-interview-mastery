DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 10 THEN
        RAISE EXCEPTION 'Expected 10 rows, got %', actual_count;
    END IF;

    -- Customer with 3 orders
    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_id = 1
          AND (order_count <> 3 OR total_spent <> 4023.00)
    ) THEN
        RAISE EXCEPTION 'Customer 1 should have 3 orders and 4023.00 total';
    END IF;

    -- Customer with 2 orders (updated totals after seed data change)
    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_id = 2
          AND (order_count <> 2 OR total_spent <> 1495.00)
    ) THEN
        RAISE EXCEPTION 'Customer 2 should have 2 orders and 1495.00 total';
    END IF;

    -- Zero-order customer
    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_id = 6
          AND (order_count <> 0 OR total_spent <> 0)
    ) THEN
        RAISE EXCEPTION 'Customer 6 should have 0 orders and 0 total';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_id = 6
          AND avg_order_value IS NOT NULL
    ) THEN
        RAISE EXCEPTION 'Customer 6 avg_order_value should be NULL';
    END IF;

    RAISE NOTICE 'PASS - Exercise 015';
END $$;
