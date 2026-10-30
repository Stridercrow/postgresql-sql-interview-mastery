# Mock Interview 01 — High-Value Customer Report

## Time Limit

30 minutes

## Difficulty

🟡 Medium

## Business Scenario

The sales team wants a report of customers who have spent more than `1000` in total across **completed orders only**.

They need:

- Customer name
- Total spending (sum of `quantity * unit_price`)
- Number of completed orders
- Most recent order date

Return only customers meeting the threshold. Order by total spending descending.

## Available Tables

```text
customers (id, name, email, country, loyalty_tier, created_at)
orders (id, customer_id, status, created_at)
order_items (id, order_id, product_id, quantity, unit_price)
```

## Requirements

1. Only include orders with `status = 'COMPLETED'`.
2. A customer with no completed orders should NOT appear.
3. Return: `customer_name`, `total_spending`, `order_count`, `last_order_date`.
4. Order by `total_spending` descending, then `customer_name` ascending.

## Hints (use only if stuck)

### Hint 1

You need to filter orders by status before joining to order items.

### Hint 2

This is a `GROUP BY` problem with a `HAVING` clause.

### Hint 3

`MAX(orders.created_at)` gives you the most recent order date per customer.

## Expected Result

Using the existing seed data:

```text
customer_name      total_spending  order_count  last_order_date
─────────────────────────────────────────────────────────────────
Adrian Baker       2666.00         2            2026-01-15
Diana Lopez        2148.00         1            2026-03-10
Beatriz Garcia     1346.00         1            2026-01-20
```

Only 3 customers have completed spending above 1000.

## Interview Discussion Points

After solving, be prepared to explain:

1. Why did you filter orders by status?
2. What would happen if you joined `order_items` before filtering?
3. Could you solve this with a subquery instead of a JOIN?
4. How would you handle ties in spending?
5. What index would help this query on a large dataset?
