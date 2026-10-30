# 023 - Top 2 Products Per Category

## Difficulty

🔴 Hard

## Concepts

- `ROW_NUMBER`
- `RANK`
- `PARTITION BY`
- Top-N-per-group
- filtering window-function results
- CTE or derived table

## Problem

Find the **top 2 products by price** within each category.

Return:

```text
category_id
category_name
product_id
product_name
price
rank_in_category
```

Order by `category_id` ascending, then `price` descending.

## Think Before Coding

1. What does `PARTITION BY category_id` do inside `OVER`?
2. Why can't you do `WHERE ROW_NUMBER() OVER (...) <= 2` in the same `SELECT`?
3. What pattern do you need instead?

## The Standard Pattern

Window functions cannot be filtered in the same `SELECT`'s `WHERE` clause:

```sql
-- This is INVALID:
SELECT *, ROW_NUMBER() OVER (...) AS rn
FROM ...
WHERE rn <= 2  -- ERROR: rn does not exist yet
```

Instead, use a **CTE or derived table**:

```text
CTE / derived table
        ↓
calculate row_number
        ↓
outer query
        ↓
filter row_number <= 2
```

## Expected result

There should be 10 rows (2 per category × 5 categories).

## Interview follow-ups

- What happens if two products in the same category have the same price?
- How would you include ties using `RANK()`?
- How does `PARTITION BY` differ from `GROUP BY`?
- What is the performance impact of window functions on large datasets?

## Challenge

Rewrite using `RANK()` instead of `ROW_NUMBER()` to include ties. With the current data the result is the same, but explain how it would differ if two products shared the same price.
