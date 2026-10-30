# 057 - Procedure With Multiple Table Updates

## Difficulty

🔴 Hard

## Concepts

- multiple SQL statements in a procedure
- validation before modification
- `INSERT` into audit/event table
- `UPDATE` on main entity
- procedural logic
- failure handling
- consistency across tables

## Suggested Time

30–40 minutes

## Problem

Create a stored procedure called `cancel_order` that cancels an existing order.

The procedure receives:

- `p_order_id` — the order to cancel

The procedure must:

1. Validate that the order exists.
2. Validate that the order is in a cancellable status (`PENDING` or `PAID`).
3. Update the order status to `CANCELLED`.
4. Record a cancellation event in the `product_events` table.
5. Raise an exception if any validation fails.

## Procedure Signature

```sql
CREATE PROCEDURE cancel_order(p_order_id BIGINT)
LANGUAGE plpgsql
```

## Validation Rules

```text
Condition                          → Error Message
─────────────────────────────────────────────────────
Order does not exist               → 'Order not found'
Order is already cancelled         → 'Order is already cancelled'
Order cannot be cancelled          → 'Order in status <status> cannot be cancelled'
```

## Event Recording

After a successful cancellation, insert an event into `product_events`:

```sql
INSERT INTO product_events (product_id, event_type, payload, created_at)
VALUES (
    <first product from order_items>,
    'ORDER_CANCELLED',
    jsonb_build_object('order_id', p_order_id, 'reason', 'customer_request'),
    CURRENT_TIMESTAMP
);
```

Use the `product_id` from the first item in the order. If the order has no items, use product `0` as a fallback.

## Expected Behavior

```sql
-- Successful: order 9 is PENDING, can be cancelled
CALL cancel_order(9);

-- Fails: order does not exist
CALL cancel_order(999);
-- ERROR: Order not found
```

## Hints

### Hint 1

First query the order status. Use `SELECT INTO` and check `FOUND`.

### Hint 2

Check the status with `IF status NOT IN ('PENDING', 'PAID') THEN RAISE EXCEPTION ...`.

### Hint 3

After the `UPDATE`, get the first product_id from `order_items` for the event record, then `INSERT` into `product_events`.

### Hint 4

Consider: what happens if step 3 succeeds but step 4 fails? PostgreSQL procedures run inside a transaction. If an exception is raised, all changes in the current transaction are rolled back.

## Interview Follow-ups

- What happens if the `INSERT INTO product_events` fails after the `UPDATE`? Does the order remain cancelled?
- How does PostgreSQL's transaction model affect procedure execution?
- Would you use a trigger instead of a procedure for audit logging?
- How would you implement this in a Spring `@Transactional` service?
