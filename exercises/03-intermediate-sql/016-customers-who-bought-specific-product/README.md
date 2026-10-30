# 016 - Customers Who Bought a Specific Product

## Difficulty

🟡 Medium

## Concepts

- `EXISTS`
- semi-join thinking
- duplicate avoidance
- correlated subquery

## Problem

Find customers who have purchased the **ThinkPad X1 Carbon** (product id `1`) at least once.

Return:

```text
customer_id
customer_name
```

Order by `customer_id`.

## Think Before Coding

1. What does `EXISTS` check? (Whether at least one matching row exists.)
2. Why might a simple `JOIN` return duplicate customers?
3. What is a "semi-join"?

## `EXISTS` answers:

> "Does at least one matching row exist?"

It does **not** return the matching rows themselves. It returns `TRUE` or `FALSE`.

## Expected result

There should be 2 rows.

## Interview follow-ups

- How does `EXISTS` differ from `IN`?
- How does `EXISTS` differ from a `JOIN`?
- What happens if a customer bought the same product in multiple orders?
- Would an `IN` subquery produce the same result here?
