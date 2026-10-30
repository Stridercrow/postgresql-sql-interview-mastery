# Mock Interview 02 — Category Revenue Rankings

## Time Limit

45 minutes

## Difficulty

🔴 Hard

## Business Scenario

The product team wants a monthly revenue breakdown by category, with each category ranked within its month.

They need to answer:

> "Which category generated the most revenue in each month, and how does it compare to other categories in the same month?"

## Available Tables

```text
categories (id, name)
products (id, category_id, name, price, ...)
orders (id, customer_id, status, created_at)
order_items (id, order_id, product_id, quantity, unit_price)
```

## Requirements

1. Calculate monthly revenue per category (using `order_items.unit_price`, not `products.price`).
2. Only include orders with `status IN ('COMPLETED', 'PAID', 'SHIPPED')`.
3. Group by year-month and category.
4. Rank categories within each month by revenue (highest first).
5. Return:

```text
month           (formatted as 'YYYY-MM')
category_name
monthly_revenue
rank_in_month
```

6. Order by `month` ascending, then `rank_in_month` ascending.

## Hints (use only if stuck)

### Hint 1

You need to join `orders → order_items → products → categories` and filter by order status.

### Hint 2

Use `DATE_TRUNC('month', orders.created_at)` to get the month.

### Hint 3

After aggregating monthly revenue per category, use a window function (`RANK` or `DENSE_RANK`) with `PARTITION BY month` to rank within each month.

### Hint 4

A CTE can help: first calculate monthly revenue, then rank.

## Expected Result

Using the existing seed data:

There are 11 rows across 3 months. Verify exact values against the seed data.

Key points:
- January has 4 categories with revenue
- February has 3 categories (including SHIPPED and PAID orders)
- March has 4 categories
- RANK() assigns position within each month by revenue descending

## Interview Discussion Points

After solving, be prepared to explain:

1. Why use `unit_price` from `order_items` instead of `products.price`?
2. How does `PARTITION BY` inside `RANK()` work?
3. Could you solve this without a CTE? How?
4. What happens if two categories have the same revenue in a month?
5. How would this query perform on a table with millions of orders?
