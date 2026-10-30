# 058 - Transactional Order Processing

## Difficulty

🔴 Hard

## Concepts

- stored procedures with `OUT` parameters
- multi-table operations
- validation
- `INSERT` returning `id`
- stock management
- audit/event logging
- transactional consistency
- atomicity
- exception handling

## Suggested Time

45–60 minutes

## Problem

Create a stored procedure called `process_order` that creates a new order from scratch.

The procedure receives:

- `p_customer_id` — the customer placing the order
- `p_product_id` — the product being ordered
- `p_quantity` — how many units

The procedure must perform a complete business operation:

1. Validate that the customer exists.
2. Validate that the product exists and is active.
3. Validate that the quantity is positive (> 0).
4. Validate that sufficient stock is available.
5. Create the order record.
6. Create the corresponding order item.
7. Decrease the product's stock.
8. Record a purchase event in `product_events`.
9. Return the created order ID.
10. Fail cleanly when any validation fails — no partial changes.

## Procedure Signature

```sql
CREATE PROCEDURE process_order(
    p_customer_id  BIGINT,
    p_product_id   BIGINT,
    p_quantity     INTEGER,
    OUT p_order_id BIGINT
)
LANGUAGE plpgsql
```

## Validation Rules

```text
Condition                          → Error Message
─────────────────────────────────────────────────────
Customer does not exist            → 'Customer not found'
Product does not exist             → 'Product not found'
Product is inactive                → 'Product is not available'
Quantity is not positive           → 'Quantity must be greater than zero'
Insufficient stock                 → 'Insufficient stock: available %, requested %'
```

## Usage

```sql
CALL process_order(1, 1, 2, NULL);
-- p_order_id will contain the new order ID
```

## Transaction Behavior

When `CALL process_order(...)` is executed, PostgreSQL wraps the call in a transaction:

```text
BEGIN
    CALL process_order(...)
        ↓
    All statements run inside one transaction
        ↓
    If any RAISE EXCEPTION occurs:
        → all changes are rolled back
        → no partial data remains
        ↓
    If all succeeds:
        → COMMIT (auto-commit when not inside an explicit transaction block)
```

Key insight: **the procedure does not need to explicitly manage transactions**. PostgreSQL handles atomicity. If step 6 (INSERT order) succeeds but step 8 (INSERT event) raises an exception, the entire call is rolled back — the order is never created.

This is different from Java/Spring:

```text
Spring @Transactional
    → Application server manages the transaction boundary
    → JPA dirty checking flushes changes
    → @Transactional rolls back on unchecked exceptions

PostgreSQL CALL
    → Client-side transaction wraps the CALL
    → Procedure logic runs inside that transaction
    → RAISE EXCEPTION rolls back everything in the transaction
```

## Hints

### Hint 1

Validate all inputs before creating any records. Check: customer exists, product exists, product is active, quantity > 0, stock sufficient.

### Hint 2

Use `INSERT ... RETURNING id INTO p_order_id` to capture the new order's ID.

### Hint 3

The order item's `unit_price` should be the product's current price (historical price), not a parameter.

### Hint 4

After inserting the order item, decrease stock: `UPDATE products SET stock_quantity = stock_quantity - p_quantity`.

### Hint 5

Record the event with `event_type = 'PURCHASED'` and a payload containing the order details.

## Expected Behavior

```sql
-- Successful order
CALL process_order(1, 1, 2, NULL);
-- Creates order for Adrian Baker, 2x ThinkPad X1 Carbon
-- Stock decreases from 25 to 23

-- Fails: insufficient stock
CALL process_order(1, 14, 100, NULL);
-- ERROR: Insufficient stock: available 10, requested 100
-- No order created
```

## Failure Scenarios to Think About

1. Customer does not exist → no order created, stock unchanged
2. Product does not exist → no order created
3. Product is inactive → no order created
4. Quantity is 0 or negative → no order created
5. Insufficient stock → no order created, stock unchanged
6. What if the INSERT event fails after the order is created? → rollback

## Interview Follow-ups

- How does this differ from implementing the same logic in a Spring `@Transactional` service?
- What happens if two concurrent `CALL` operations try to order the last unit of a product?
- How would you handle race conditions on stock?
- Would you use `SELECT ... FOR UPDATE` to lock the product row?
- When would you choose a stored procedure over a JPA repository method?
- How does this approach affect database scalability?
