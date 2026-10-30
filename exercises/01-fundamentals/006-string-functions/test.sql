DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 10 THEN
        RAISE EXCEPTION 'Expected 10 rows, got %', actual_count;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE normalized_email <> LOWER(TRIM((SELECT email FROM customers WHERE customers.id = exercise_answer.id)))
    ) THEN
        RAISE EXCEPTION 'normalized_email is incorrect';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE email_domain <> 'example.test'
    ) THEN
        RAISE EXCEPTION 'email_domain is incorrect';
    END IF;

    RAISE NOTICE 'PASS - Exercise 006';
END $$;
