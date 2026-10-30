# 002 - Sorting & Pagination

## Difficulty

🟢 Easy

## Concepts

- `ORDER BY`
- `LIMIT`
- `OFFSET`
- Deterministic pagination

## Problem

Return the **second page** of active products.

Rules:

- page size = 5
- page number = 2
- sort by `price DESC, id ASC`

Return:

```text
id
name
price
```

## Expected result

The result contains exactly 5 products.

## Interview follow-ups

- Why should `id` be included as a tie-breaker?
- What happens to OFFSET pagination when the offset becomes very large?
- What is keyset/cursor pagination?
