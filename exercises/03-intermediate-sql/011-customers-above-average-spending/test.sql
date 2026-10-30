DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 2 THEN
        RAISE EXCEPTION 'Expected 2 rows, got %', actual_count;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Adrian Baker'
          AND total_spending = 4023.00
    ) THEN
        RAISE EXCEPTION 'Adrian Baker with spending 4023.00 should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Diana Lopez'
          AND total_spending = 2148.00
    ) THEN
        RAISE EXCEPTION 'Diana Lopez with spending 2148.00 should be in the result';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE customer_name = 'Beatriz Garcia'
    ) THEN
        RAISE EXCEPTION 'Beatriz Garcia should not be above the average';
    END IF;

    RAISE NOTICE 'PASS - Exercise 011';
END $$;
