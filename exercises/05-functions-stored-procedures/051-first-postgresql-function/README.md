# 051 - First PostgreSQL Function

## Difficulty

🟢 Easy

## Concepts

- `CREATE FUNCTION`
- function parameters
- `RETURNS`
- `LANGUAGE plpgsql`
- `RETURN` statement
- basic function body

## Suggested Time

10–15 minutes

## Problem

Create a PostgreSQL function called `calculate_discount` that receives:

- `p_price` — the original price (`NUMERIC`)
- `p_discount_percent` — the discount percentage (`NUMERIC`, e.g. `10` means 10%)

The function should return the discounted price as `NUMERIC`.

```text
discounted_price = price - (price * discount_percent / 100)
```

## Examples

```text
calculate_discount(100.00, 10)  → 90.00
calculate_discount(250.00, 20)  → 200.00
calculate_discount(50.00, 0)    → 50.00
calculate_discount(50.00, 100)  → 0.00
```

## Function Signature

```sql
CREATE FUNCTION calculate_discount(
    p_price NUMERIC,
    p_discount_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
```

## Notes

- Do not worry about edge cases like `NULL` for this exercise.
- The function performs pure computation — it does not query any tables.
- Focus on getting the syntax right: `CREATE FUNCTION`, parameters, `RETURNS`, `LANGUAGE`, and `RETURN`.

## Interview Follow-ups

- What happens if `p_price` is `NULL`?
- What happens if `p_discount_percent` is negative?
- Could you write this function in `SQL` language instead of `plpgsql`? What would change?
- How would a Spring application call this function?
- What is the difference between `LANGUAGE sql` and `LANGUAGE plpgsql` for simple functions?
