SELECT
    id,
    customer_id,
    status,
    created_at
FROM orders
WHERE created_at >= TIMESTAMP '2026-02-01 00:00:00'
  AND created_at <  TIMESTAMP '2026-03-01 00:00:00'
ORDER BY created_at ASC;
