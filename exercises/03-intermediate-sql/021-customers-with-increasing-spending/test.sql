DO $$
DECLARE
    actual_count INTEGER;
    actual_ids BIGINT[];
    expected_ids BIGINT[] := ARRAY[3];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 1 THEN
        RAISE EXCEPTION 'Expected 1 row, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(customer_id ORDER BY customer_id)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected customer ids %, got %', expected_ids, actual_ids;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_id = 3
          AND customer_name = 'Carlos Hernandez'
    ) THEN
        RAISE EXCEPTION 'Carlos Hernandez (customer 3) should be the only result';
    END IF;

    -- Verify Carlos actually had increasing spending:
    -- Feb: 508.00, Mar: 967.00
    IF (
        SELECT SUM(spending)
        FROM (
            SELECT DATE_TRUNC('month', o.created_at) AS month,
                   SUM(oi.quantity * oi.unit_price) AS spending
            FROM orders o
            JOIN order_items oi ON oi.order_id = o.id
            WHERE o.customer_id = 3
            GROUP BY DATE_TRUNC('month', o.created_at)
        ) monthly
        WHERE month = '2026-03-01'::timestamp
    ) <= (
        SELECT SUM(spending)
        FROM (
            SELECT DATE_TRUNC('month', o.created_at) AS month,
                   SUM(oi.quantity * oi.unit_price) AS spending
            FROM orders o
            JOIN order_items oi ON oi.order_id = o.id
            WHERE o.customer_id = 3
            GROUP BY DATE_TRUNC('month', o.created_at)
        ) monthly
        WHERE month = '2026-02-01'::timestamp
    ) THEN
        RAISE EXCEPTION 'Carlos should have increasing spending from Feb to Mar';
    END IF;

    RAISE NOTICE 'PASS - Exercise 021';
END $$;
