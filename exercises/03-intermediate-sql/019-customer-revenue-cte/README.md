# 019 - Customer Revenue CTE

## Difficulty

🟡 Medium

## Concepts

- CTE
- `WITH`
- aggregation
- multi-stage query design

## Problem

Build a CTE containing customer-level revenue, then use that CTE to identify customers whose total revenue is greater than `1000`.

Return:

```text
customer_id
customer_name
total_revenue
```

Order by `total_revenue` descending.

## Think Before Coding

1. What is an intermediate result you need before the final answer?
2. How does a CTE make the two stages explicit?
3. Why is this easier to read than nesting subqueries?

## Multi-Stage Query Design

Many real-world queries require building an intermediate result and then querying that result:

```text
Stage 1: Calculate revenue per customer (CTE)
    ↓
Stage 2: Filter customers above threshold (main query)
```

A `CTE` (`WITH` clause) makes each stage a named, readable block.

## Expected result

There should be 3 rows.

## Interview follow-ups

- How would you write this without a `CTE` (using subqueries or derived tables)?
- What are the readability advantages of CTEs?
- Can you reference a CTE multiple times in the same query?
- How does PostgreSQL optimize CTEs?

## Challenge

Rewrite the solution without using a `CTE`. Compare the readability.
