# 013 - Customers With Multiple Orders

## Difficulty

🟡 Medium

## Concepts

- `GROUP BY`
- `COUNT`
- `HAVING`

## Problem

Find customers who have placed **at least 3 orders**.

Return:

```text
customer_id
customer_name
order_count
```

Order by `order_count` descending, then `customer_id` ascending.

## Think Before Coding

1. What is the result grain? (One row per customer.)
2. What is being grouped?
3. Are we filtering individual orders or customer groups?
4. Why does the filtering condition belong in `HAVING`?

## Why not `WHERE`?

You might be tempted to write:

```sql
WHERE COUNT(*) >= 3
```

This is **invalid**. Aggregate functions like `COUNT(*)` cannot appear in a `WHERE` clause. `WHERE` filters individual rows **before** grouping. `HAVING` filters groups **after** grouping.

## Expected result

There should be 1 row.

## Interview follow-ups

- When would you use `WHERE` vs `HAVING`?
- Can `HAVING` be used without `GROUP BY`?
- What happens if two customers have the same order count?
- How would the query change if you needed customers with at least 2 orders?
