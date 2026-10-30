# 055 - First Stored Procedure

## Difficulty

🟡 Medium

## Concepts

- `CREATE PROCEDURE`
- `CALL`
- procedure parameters
- `UPDATE` inside a procedure
- function vs procedure distinction

## Suggested Time

20–25 minutes

## Problem

Create a stored procedure called `update_customer_tier` that receives a customer ID and updates the customer's `loyalty_tier` column based on their total spending.

Classification rules:

```text
Total spending >= 3000  →  GOLD
Total spending >= 1000  →  SILVER
Otherwise               →  BRONZE
```

If the customer does not exist, the procedure should do nothing.

## Function vs Procedure

```text
FUNCTION
    └── CREATE FUNCTION ... RETURNS type
    └── Called in SQL: SELECT my_func(...)
    └── Returns a value
    └── Cannot COMMIT or ROLLBACK

PROCEDURE
    └── CREATE PROCEDURE ...
    └── Called with: CALL my_proc(...)
    └── Does not return a value directly
    └── Can COMMIT and ROLLBACK
```

Key distinction: a **function** returns a result that can be used in expressions. A **procedure** performs operations with side effects.

## Procedure Signature

```sql
CREATE PROCEDURE update_customer_tier(p_customer_id BIGINT)
LANGUAGE plpgsql
```

## Usage

```sql
CALL update_customer_tier(1);
```

## Expected Behavior

After calling `CALL update_customer_tier(1)`:

```sql
SELECT loyalty_tier FROM customers WHERE id = 1;
-- Should return 'GOLD'
```

## Hints

### Hint 1

Use `CREATE PROCEDURE` instead of `CREATE FUNCTION`. Procedures do not have `RETURNS`.

### Hint 2

The procedure queries total spending (same calculation as exercise 054) and then runs an `UPDATE` statement.

### Hint 3

Use `IF / ELSIF / ELSE` to determine the tier, then `UPDATE customers SET loyalty_tier = ... WHERE id = p_customer_id`.

## Interview Follow-ups

- When would you choose a function over a procedure?
- Can a function modify data in PostgreSQL? (Yes — but it cannot manage transactions.)
- How would Spring call this procedure?
- What happens if you call `COMMIT` inside a function? (It raises an error.)
