DO $$
DECLARE
    actual_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 16 THEN
        RAISE EXCEPTION 'Expected 16 rows, got %', actual_count;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE (price < 50 AND price_band <> 'CHEAP')
           OR (price >= 50 AND price <= 200 AND price_band <> 'STANDARD')
           OR (price > 200 AND price_band <> 'PREMIUM')
    ) THEN
        RAISE EXCEPTION 'At least one price band is incorrect';
    END IF;

    RAISE NOTICE 'PASS - Exercise 004';
END $$;
