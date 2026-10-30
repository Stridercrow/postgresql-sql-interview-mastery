# 021 - Customers With Increasing Spending

## Difficulty

🔴 Hard

## Concepts

- CTE
- multiple levels of aggregation
- comparing monthly results
- query decomposition

## Problem

Identify customers whose spending **increased** from one month to the next.

Return:

```text
customer_id
customer_name
```

Order by `customer_id`.

## Think Before Coding

1. What intermediate result do you need before comparing months?
2. How do you pair each customer's spending in one month with the previous month?
3. Why is this a multi-stage problem?

## Query Decomposition

Break the problem into stages:

```text
Stage 1: Calculate monthly spending per customer (CTE)
    ↓
Stage 2: Compare consecutive months (self-join or window function)
    ↓
Stage 3: Filter customers where spending increased
```

## Expected result

There should be 1 row.

## Interview follow-ups

- How would you solve this using a `LAG()` window function?
- How would you handle months where a customer had no orders?
- What if you needed the percentage increase?
- How does the self-join approach compare to `LAG()` in terms of readability?

## Advanced Alternative

Once you have solved this with CTEs and a self-join, try rewriting with `LAG()`:

```sql
LAG(spending) OVER (PARTITION BY customer_id ORDER BY month)
```

This is a preview of window functions covered in exercises 022-023.
