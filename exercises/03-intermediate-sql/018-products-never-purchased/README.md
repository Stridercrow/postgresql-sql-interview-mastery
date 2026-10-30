# 018 - Products Never Purchased

## Difficulty

🟡 Medium

## Concepts

- anti-join
- `LEFT JOIN ... IS NULL`
- `NOT EXISTS`

## Problem

Find products that have **never appeared in any order item**.

Return:

```text
id
name
price
```

Order by `id`.

## Think Before Coding

1. What is an anti-join?
2. How does `LEFT JOIN ... IS NULL` find rows with no match?
3. How does `NOT EXISTS` achieve the same result?

## Anti-Join Pattern

An anti-join finds rows in one table that have **no matching row** in another table.

Two common approaches:

1. `LEFT JOIN ... IS NULL`
2. `NOT EXISTS`

Both are logically equivalent for this problem. The choice often comes down to readability and performance.

## Expected result

There should be 2 rows.

## Interview follow-ups

- How would you find products that were viewed but never purchased?
- What is the performance difference between `LEFT JOIN ... IS NULL` and `NOT EXISTS`?
- When might one approach be preferred over the other?
