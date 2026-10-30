DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 3 THEN
        RAISE EXCEPTION 'Expected 3 rows, got %', actual_count;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Adrian Baker'
          AND total_revenue = 4023.00
    ) THEN
        RAISE EXCEPTION 'Adrian Baker with revenue 4023.00 should be first';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Diana Lopez'
          AND total_revenue = 2148.00
    ) THEN
        RAISE EXCEPTION 'Diana Lopez with revenue 2148.00 should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Carlos Hernandez'
          AND total_revenue = 1475.00
    ) THEN
        RAISE EXCEPTION 'Carlos Hernandez with revenue 1475.00 should be in the result';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Ethan Brown'
    ) THEN
        RAISE EXCEPTION 'Ethan Brown (revenue 38.00) should not be in the result';
    END IF;

    RAISE NOTICE 'PASS - Exercise 019';
END $$;
