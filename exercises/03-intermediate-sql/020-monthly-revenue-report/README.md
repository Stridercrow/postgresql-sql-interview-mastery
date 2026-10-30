# 020 - Monthly Revenue Report

## Difficulty

🟡 Medium

## Concepts

- CTE
- date aggregation
- `DATE_TRUNC`
- grouping by month
- multi-stage reporting

## Problem

Produce a monthly revenue report from the order data.

Return:

```text
month
order_count
revenue
```

- `month` should be truncated to the first day of the month.
- `order_count` should count distinct orders.
- `revenue` should be the total of `quantity * unit_price` across all order items.

Order by `month`.

## Think Before Coding

1. Why can't you group by `created_at` directly?
2. What does `DATE_TRUNC('month', ...)` return?
3. Why is `COUNT(DISTINCT o.id)` needed instead of `COUNT(*)`?

## Date Truncation

`DATE_TRUNC('month', timestamp)` returns the first day of the month:

```sql
DATE_TRUNC('month', '2026-03-15 14:30:00')
-- Returns: 2026-03-01 00:00:00
```

Grouping by raw timestamps creates one row per exact timestamp. Grouping by truncated month creates one row per calendar month.

## Expected result

There should be 3 rows.

## Interview follow-ups

- What is the difference between `DATE_TRUNC` and `EXTRACT`?
- How would you include months with zero revenue?
- Why might grouping by `created_at::date` produce different results?
- How would you add a running total column?
