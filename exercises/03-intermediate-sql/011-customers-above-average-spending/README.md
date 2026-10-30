# 011 - Customers Above Average Spending

## Difficulty

🟡 Medium

## Concepts

- `GROUP BY`
- aggregate functions
- subquery
- comparing an aggregate result against another aggregate result
- result grain

## Problem

Find customers whose **total spending** is greater than the **average customer spending**.

Return:

```text
customer_id
customer_name
total_spending
```

Order by `total_spending` descending.

## Think Before Coding

1. What is the result grain? (One row per customer.)
2. How do you calculate each customer's total spending?
3. How do you calculate the average of those per-customer totals?
4. Why does the inner query need its own `GROUP BY`?

## Expected result

There should be 2 rows.

## Interview follow-ups

- What happens if you include customers with zero orders in the average calculation?
- How would you write this using a `CTE` or derived table instead of a subquery?
- Could you solve this with a window function?

## Challenge

Rewrite the solution using a `CTE` to make the two aggregation levels explicit.
