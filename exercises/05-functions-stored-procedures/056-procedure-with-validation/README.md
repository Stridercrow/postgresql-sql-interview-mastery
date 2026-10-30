# 056 - Procedure With Validation

## Difficulty

🟡 Medium

## Concepts

- `RAISE EXCEPTION`
- input validation
- conditional logic
- controlled failure
- error messages

## Suggested Time

25–30 minutes

## Problem

Create a stored procedure called `apply_discount` that applies a discount to a product's price.

The procedure receives:

- `p_product_id` — the product to discount
- `p_discount_percent` — the discount percentage (must be between 0 and 50, inclusive)

The procedure must validate the input before making any changes:

1. The product must exist.
2. The product must be active (`active = TRUE`).
3. The discount must be between 0 and 50 (inclusive).
4. The resulting price must be at least `1.00` (products cannot be discounted below 1.00).

If any validation fails, raise an exception with a descriptive message.

If all validations pass, update the product's price to the discounted value.

## Procedure Signature

```sql
CREATE PROCEDURE apply_discount(
    p_product_id BIGINT,
    p_discount_percent NUMERIC
)
LANGUAGE plpgsql
```

## Validation Rules

```text
Condition                          → Error Message
─────────────────────────────────────────────────────
Product does not exist             → 'Product not found'
Product is inactive                → 'Cannot discount an inactive product'
Discount < 0 or > 50               → 'Discount must be between 0 and 50'
Discounted price < 1.00            → 'Discounted price would be below minimum'
```

## Expected Behavior

```sql
-- Successful: ThinkPad price drops from 1450.00 to 1160.00
CALL apply_discount(1, 20);

-- Fails: product does not exist
CALL apply_discount(999, 10);
-- ERROR: Product not found

-- Fails: inactive product
CALL apply_discount(4, 10);
-- ERROR: Cannot discount an inactive product

-- Fails: discount out of range
CALL apply_discount(1, 60);
-- ERROR: Discount must be between 0 and 50
```

## Important

Tests will verify both successful and failed scenarios. Your procedure must raise exceptions on invalid input — do not silently ignore errors.

## Hints

### Hint 1

Check if the product exists with `SELECT INTO` and check `FOUND`:

```sql
SELECT id INTO v_exists FROM products WHERE id = p_product_id;
IF NOT FOUND THEN
    RAISE EXCEPTION 'Product not found';
END IF;
```

### Hint 2

After the existence check, validate the other conditions with `IF` statements, raising `RAISE EXCEPTION` for each failure.

### Hint 3

Only update the price if all validations pass.

## Interview Follow-ups

- How would you handle validation in a Spring service instead?
- What is the difference between `RAISE EXCEPTION` and `RAISE NOTICE`?
- How does PostgreSQL handle exceptions in a procedure — does the previous work get rolled back?
- Would you put this validation in the database layer or the application layer in production?
