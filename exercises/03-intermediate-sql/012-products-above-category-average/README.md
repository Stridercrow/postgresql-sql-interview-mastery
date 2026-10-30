# 012 - Products Above Category Average

## Difficulty

🟡 Medium

## Concepts

- correlated subquery
- `GROUP BY`
- `AVG`
- comparison against a group-specific average

## Problem

Find products whose price is greater than the **average price of products in their own category**.

The comparison must be **within the product's category**, not against the global average.

Return:

```text
id
name
price
category_id
```

Order by `category_id` ascending, then `price` descending.

## Think Before Coding

1. What is the result grain? (One row per qualifying product.)
2. How do you compute the average for a specific category?
3. How does the correlated subquery reference the outer row's category?

## Expected result

There should be 7 rows.

## Interview follow-ups

- How would you rewrite this using a `JOIN` with a derived table or `CTE`?
- What is the difference in readability between a correlated subquery and a `JOIN` approach?
- Would an index on `(category_id, price)` help this query?

## Challenge

Rewrite the solution using a `JOIN` with a derived table that precomputes category averages.
