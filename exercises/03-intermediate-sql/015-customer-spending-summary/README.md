# 015 - Customer Spending Summary

## Difficulty

🟡 Medium

## Concepts

- `LEFT JOIN`
- `GROUP BY`
- `COUNT`
- `SUM`
- `AVG`
- handling customers with zero orders
- `COALESCE`
- aggregation after joins

## Problem

For every customer, calculate:

```text
customer_id
customer_name
order_count
total_spent
avg_order_value
```

Rules:

- Customers who have **never placed an order** must also appear.
- `order_count` should be `0` for customers with no orders.
- `total_spent` should be `0` for customers with no orders.
- `avg_order_value` should be `NULL` for customers with no orders.

Order by `customer_id`.

## Think Before Coding

1. Why is a `LEFT JOIN` needed here?
2. What happens to `COUNT` with a `LEFT JOIN`? Can you use `COUNT(*)`?
3. How does `COALESCE` handle NULL after a `LEFT JOIN`?
4. Why does the `AVG` result become `NULL` for zero-order customers?

## Important

Be careful with `COUNT(*)` after a `LEFT JOIN`. It counts the row even when the join produces NULLs. Use `COUNT(order_id)` or `COUNT(DISTINCT order_id)` instead.

## Expected result

There should be 10 rows.

## Interview follow-ups

- Why does changing `LEFT JOIN` to `INNER JOIN` change the result?
- What is the difference between `COUNT(*)` and `COUNT(o.id)` after a `LEFT JOIN`?
- How would this query change if you only wanted customers with at least one order?
