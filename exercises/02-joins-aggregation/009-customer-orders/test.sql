DO $$
DECLARE
    actual_count INTEGER;
    actual_customers BIGINT[];
    expected_customers BIGINT[] := ARRAY[1,1,1,2,2,3,3,4,5];
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 9 THEN
        RAISE EXCEPTION 'Expected 9 rows, got %', actual_count;
    END IF;

    SELECT ARRAY_AGG(customer_id ORDER BY customer_id, order_date, order_id)
    INTO actual_customers
    FROM exercise_answer;

    IF actual_customers <> expected_customers THEN
        RAISE EXCEPTION 'Unexpected customer/order join result: %', actual_customers;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer a
        LEFT JOIN orders o ON o.id = a.order_id
        WHERE o.id IS NULL
           OR o.customer_id <> a.customer_id
    ) THEN
        RAISE EXCEPTION 'At least one result row has an invalid customer/order relationship';
    END IF;

    RAISE NOTICE 'PASS - Exercise 009';
END $$;
