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
        WHERE department_name = 'Finance'
          AND average_salary = 130000.00
    ) THEN
        RAISE EXCEPTION 'Finance with average salary 130000 should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE department_name = 'Engineering'
          AND average_salary = 121250.00
    ) THEN
        RAISE EXCEPTION 'Engineering with average salary 121250 should be in the result';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE department_name = 'Product'
          AND average_salary = 120000.00
    ) THEN
        RAISE EXCEPTION 'Product with average salary 120000 should be in the result';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE department_name = 'Sales'
    ) THEN
        RAISE EXCEPTION 'Sales should not be in the result (avg salary 97500)';
    END IF;

    RAISE NOTICE 'PASS - Exercise 014';
END $$;
