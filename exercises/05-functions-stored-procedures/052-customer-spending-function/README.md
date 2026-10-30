# 052 - Customer Spending Function

## Difficulty

🟡 Medium

## Concepts

- function parameters
- querying tables from a function
- `SELECT INTO`
- `SUM`
- local variables
- `DECLARE`
- `NULL` handling with `COALESCE`

## Suggested Time

15–20 minutes

## Problem

Create a function called `get_customer_spending` that receives a customer ID and returns the customer's total spending across all orders.

Total spending is calculated as:

```sql
SUM(quantity * unit_price)
```

from `order_items` joined through `orders`.

Return `0` when the customer exists but has no orders.

## Function Signature

```sql
CREATE FUNCTION get_customer_spending(p_customer_id BIGINT)
RETURNS NUMERIC
LANGUAGE plpgsql
```

## Examples

Using the existing seed data:

```text
get_customer_spending(1)  → 4023.00   (Adrian Baker, 3 orders)
get_customer_spending(5)  → 38.00     (Ethan Brown, 1 order)
get_customer_spending(6)  → 0         (Fatima Ali, no orders)
get_customer_spending(999) → 0        (non-existent customer)
```

## Expected Behavior

| Scenario | Expected Result |
|---|---|
| Customer exists, has orders | Sum of `quantity * unit_price` across all orders |
| Customer exists, no orders | `0` |
| Customer does not exist | `0` |

## Hints

### Hint 1

Use `SELECT INTO` to store the aggregate result into a local variable.

### Hint 2

`SUM` returns `NULL` when there are no rows. Use `COALESCE` to convert `NULL` to `0`.

### Hint 3

If the customer does not exist, the `LEFT JOIN` will produce no matching rows — `SUM` returns `NULL`, which `COALESCE` converts to `0`.

## Interview Follow-ups

- How would you implement this operation in a Spring service using JPA?
- What is the difference between a database function and a repository method for this query?
- Could this function be vulnerable to SQL injection? Why or why not?
- When would you prefer a database function over a JPQL `@Query`?
