SELECT
    id,
    LOWER(TRIM(email)) AS normalized_email,
    SPLIT_PART(LOWER(TRIM(email)), '@', 2) AS email_domain
FROM customers
ORDER BY id;
