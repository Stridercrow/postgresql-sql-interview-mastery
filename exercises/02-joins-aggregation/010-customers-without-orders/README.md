# 010 - Customers Without Orders

## Difficulty

🟡 Medium

## Concepts

- `LEFT JOIN`
- anti-joins
- `NULL` after an outer join

## Problem

Return customers who have **never placed an order**.

Return:

```text
customer_id
customer_name
```

Order by `customer_id`.

Expected customers:

```text
Fatima Ali
George Martin
Hannah Wilson
Ivan Petrov
Julia Rossi
```

## Interview follow-ups

Solve the same problem using:

1. `LEFT JOIN ... IS NULL`
2. `NOT EXISTS`

Then explain which approach you prefer and why.

## Important

Do not accidentally turn your `LEFT JOIN` into an `INNER JOIN` by placing the order condition in the `WHERE` clause incorrectly.
