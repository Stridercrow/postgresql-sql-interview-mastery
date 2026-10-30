DO $$
DECLARE
    actual_count INTEGER;
    r RECORD;
BEGIN
    SELECT COUNT(*) INTO actual_count FROM exercise_answer;

    -- 11 rows: 4 in Jan + 3 in Feb + 4 in Mar
    IF actual_count <> 11 THEN
        RAISE EXCEPTION 'Expected 11 rows, got %', actual_count;
    END IF;

    -- January: Laptops #1
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-01' AND category_name = 'Laptops';

    IF r.rank_in_month <> 1 OR r.monthly_revenue <> 2449.00 THEN
        RAISE EXCEPTION 'Jan Laptops: expected rank=1 revenue=2449.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    -- January: Monitors #2
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-01' AND category_name = 'Monitors';

    IF r.rank_in_month <> 2 OR r.monthly_revenue <> 998.00 THEN
        RAISE EXCEPTION 'Jan Monitors: expected rank=2 revenue=998.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    -- January: Keyboards #3
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-01' AND category_name = 'Keyboards';

    IF r.rank_in_month <> 3 OR r.monthly_revenue <> 466.00 THEN
        RAISE EXCEPTION 'Jan Keyboards: expected rank=3 revenue=466.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    -- February: Laptops #1
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-02' AND category_name = 'Laptops';

    IF r.rank_in_month <> 1 OR r.monthly_revenue <> 1299.00 THEN
        RAISE EXCEPTION 'Feb Laptops: expected rank=1 revenue=1299.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    -- February: Networking #2
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-02' AND category_name = 'Networking';

    IF r.rank_in_month <> 2 OR r.monthly_revenue <> 508.00 THEN
        RAISE EXCEPTION 'Feb Networking: expected rank=2 revenue=508.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    -- March: Laptops #1
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-03' AND category_name = 'Laptops';

    IF r.rank_in_month <> 1 OR r.monthly_revenue <> 1450.00 THEN
        RAISE EXCEPTION 'Mar Laptops: expected rank=1 revenue=1450.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    -- March: Monitors #2
    SELECT * INTO r
    FROM exercise_answer
    WHERE month = '2026-03' AND category_name = 'Monitors';

    IF r.rank_in_month <> 2 OR r.monthly_revenue <> 1397.00 THEN
        RAISE EXCEPTION 'Mar Monitors: expected rank=2 revenue=1397.00, got rank=% revenue=%',
            r.rank_in_month, r.monthly_revenue;
    END IF;

    RAISE NOTICE 'PASS - Mock Interview 02';
END $$;
