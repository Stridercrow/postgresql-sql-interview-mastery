DO $$
DECLARE
    unknown_count INTEGER;
    unknown_name TEXT;
BEGIN
    SELECT COUNT(*)
    INTO unknown_count
    FROM exercise_answer
    WHERE country IS NULL;

    IF unknown_count <> 1 THEN
        RAISE EXCEPTION 'Expected 1 customer with NULL country, got %', unknown_count;
    END IF;

    SELECT name
    INTO unknown_name
    FROM exercise_answer
    WHERE country IS NULL;

    IF unknown_name <> 'George Martin' THEN
        RAISE EXCEPTION 'Expected George Martin, got %', unknown_name;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE country IS NULL
          AND country_display <> 'Unknown'
    ) THEN
        RAISE EXCEPTION 'NULL countries must display as Unknown';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM exercise_answer
        WHERE country IS NOT NULL
          AND country_display <> country
    ) THEN
        RAISE EXCEPTION 'Non-NULL countries must be preserved';
    END IF;

    RAISE NOTICE 'PASS - Exercise 005';
END $$;
