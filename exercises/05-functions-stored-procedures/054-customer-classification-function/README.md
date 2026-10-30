# 054 - Customer Classification Function

## Difficulty

🟡 Medium

## Concepts

- `DECLARE` — local variables
- `SELECT INTO` — capturing query results
- `IF / ELSIF / ELSE` — conditional logic
- `RETURN` — returning values from procedural code
- business logic inside a database function

## Suggested Time

20 minutes

## Problem

Create a function called `classify_customer` that receives a customer ID and classifies the customer into a spending tier based on their total spending.

Classification rules:

```text
Total spending >= 3000  →  GOLD
Total spending >= 1000  →  SILVER
Otherwise               →  BRONZE
```

If the customer does not exist or has no orders, return `'BRONZE'`.

## Function Signature

```sql
CREATE FUNCTION classify_customer(p_customer_id BIGINT)
RETURNS VARCHAR(20)
LANGUAGE plpgsql
```

## Expected Results

Using the existing seed data:

```text
classify_customer(1)  → GOLD     (Adrian Baker, spending: 4023)
classify_customer(2)  → SILVER   (Beatriz Garcia, spending: 1495)
classify_customer(3)  → SILVER   (Carlos Hernandez, spending: 1475)
classify_customer(4)  → GOLD     (Diana Lopez, spending: 2148)
classify_customer(5)  → BRONZE   (Ethan Brown, spending: 38)
classify_customer(6)  → BRONZE   (Fatima Ali, no orders)
classify_customer(999)→ BRONZE   (non-existent)
```

## Hints

### Hint 1

Declare a local variable for total spending using `DECLARE v_total NUMERIC`.

### Hint 2

Use `SELECT INTO` to populate the variable:

```sql
SELECT COALESCE(SUM(...), 0) INTO v_total
FROM ...
WHERE customer_id = p_customer_id;
```

### Hint 3

Use `IF / ELSIF / ELSE` to classify and `RETURN` the tier string.

## Interview Follow-ups

- What are the advantages and disadvantages of putting this classification logic in the database instead of Java?
- How would this function be tested in a unit test?
- Would you use `@Function` or `@NamedStoredProcedureQuery` in JPA to call this?
- How does database-side classification affect caching strategies?
