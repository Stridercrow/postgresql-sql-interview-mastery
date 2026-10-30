DO $$
DECLARE
    actual_count INTEGER;
    actual_ids BIGINT[];
    expected_ids BIGINT[] := ARRAY[6,7,8,9,10];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 5 THEN
        RAISE EXCEPTION 'Expected 5 customers without orders, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(customer_id ORDER BY customer_id)
    INTO actual_ids
    FROM exercise_answer;

    IF actual_ids <> expected_ids THEN
        RAISE EXCEPTION 'Expected customer ids %, got %', expected_ids, actual_ids;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer a
        WHERE EXISTS (
            SELECT 1
            FROM orders o
            WHERE o.customer_id = a.customer_id
        )
    ) THEN
        RAISE EXCEPTION 'Result contains a customer who has an order';
    END IF;

    RAISE NOTICE 'PASS - Exercise 010';
END $$;
