# 017 - Customers Who Bought Every Product in a Category

## Difficulty

🔴 Hard

## Concepts

- `GROUP BY`
- `HAVING`
- `COUNT(DISTINCT ...)`
- relational division
- `NOT EXISTS` as an alternative

## Problem

Find customers who have purchased **every product** in the **Keyboards** category (category id `3`).

Return:

```text
customer_id
customer_name
```

Order by `customer_id`.

## Think Before Coding

1. What are all the products in the Keyboards category?
2. How many distinct products does each customer need to match?
3. How do you count only the distinct products a customer bought in that category?
4. Why is `COUNT(DISTINCT product_id)` necessary here?

## Relational Division Pattern

This is a classic interview problem. The pattern is:

```text
customer
    ↓
products purchased
    ↓
compare against products required
```

> "Find X where X has ALL of Y."

The `HAVING COUNT(DISTINCT ...) = (total count)` pattern solves this.

## Expected result

There should be 1 row.

## Interview follow-ups

- How would you solve this using `NOT EXISTS`?
- How does this pattern scale if the category has many products?
- What if you needed customers who bought every product in **multiple** categories?
- Why is this called "relational division"?

## Challenge

Rewrite the solution using `NOT EXISTS`:

```sql
-- "There does NOT exist a product in the category
--  that this customer has NOT purchased."
```
