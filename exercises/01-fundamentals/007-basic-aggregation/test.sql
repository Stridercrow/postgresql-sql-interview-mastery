DO $$
DECLARE
    r RECORD;
BEGIN
    SELECT * INTO r FROM exercise_answer;

    IF r.customer_count <> 10 THEN
        RAISE EXCEPTION 'Expected 10 customers, got %', r.customer_count;
    END IF;

    IF r.order_count <> 9 THEN
        RAISE EXCEPTION 'Expected 9 orders, got %', r.order_count;
    END IF;

    IF r.minimum_product_price <> 19.00 THEN
        RAISE EXCEPTION 'Expected minimum price 19, got %', r.minimum_product_price;
    END IF;

    IF r.maximum_product_price <> 1450.00 THEN
        RAISE EXCEPTION 'Expected maximum price 1450, got %', r.maximum_product_price;
    END IF;

    IF r.average_product_price IS NULL THEN
        RAISE EXCEPTION 'Average product price must not be NULL';
    END IF;

    RAISE NOTICE 'PASS - Exercise 007';
END $$;
