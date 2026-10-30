DO $$
DECLARE
    actual_count INTEGER;
    r RECORD;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    IF actual_count <> 10 THEN
        RAISE EXCEPTION 'Expected 10 rows, got %', actual_count;
    END IF;

    -- Check Adrian is ranked #1
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Adrian Baker';

    IF r.row_num <> 1 OR r.rank_num <> 1 OR r.dense_rank_num <> 1 THEN
        RAISE EXCEPTION 'Adrian Baker should be ranked #1 on all metrics';
    END IF;

    IF r.total_spending <> 4023.00 THEN
        RAISE EXCEPTION 'Adrian Baker spending should be 4023.00';
    END IF;

    -- Check Diana is ranked #2
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Diana Lopez';

    IF r.row_num <> 2 OR r.rank_num <> 2 OR r.dense_rank_num <> 2 THEN
        RAISE EXCEPTION 'Diana Lopez should be ranked #2 on all metrics';
    END IF;

    -- Check zero-spend customers all have rank 6 (5 customers ahead)
    SELECT * INTO r
    FROM exercise_answer
    WHERE customer_name = 'Fatima Ali';

    IF r.rank_num <> 6 OR r.dense_rank_num <> 6 THEN
        RAISE EXCEPTION 'Fatima Ali should have rank 6 and dense_rank 6, got rank=% dense_rank=%',
            r.rank_num, r.dense_rank_num;
    END IF;

    IF r.row_num < 6 THEN
        RAISE EXCEPTION 'Fatima Ali row_num should be >= 6, got %', r.row_num;
    END IF;

    -- Verify all 5 zero-spend customers have unique row_numbers
    IF (
        SELECT COUNT(DISTINCT row_num)
        FROM exercise_answer
        WHERE total_spending = 0
    ) <> 5 THEN
        RAISE EXCEPTION 'Zero-spend customers should have 5 distinct row_numbers';
    END IF;

    RAISE NOTICE 'PASS - Exercise 022';
END $$;
