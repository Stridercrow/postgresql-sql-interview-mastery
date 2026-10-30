# 001 - Basic Filtering

## Difficulty

🟢 Easy

## Concepts

- `SELECT`
- `WHERE`
- Boolean predicates
- Comparison operators

## Problem

Return all **active products** with a price greater than `100`.

Return exactly these columns:

```text
id
name
price
```

Order the result by `price` descending, then `id` ascending.

## Expected result

There should be 9 rows.

## Interview follow-ups

- What happens if `price` is `NULL`?
- What is the difference between `WHERE` and `HAVING`?
- Would an index on `active` and `price` necessarily improve this query?
