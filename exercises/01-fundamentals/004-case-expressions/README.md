# 004 - CASE Expressions

## Difficulty

🟢 Easy

## Concepts

- `CASE`
- Conditional projections
- Derived columns

## Problem

Return every product with:

```text
id
name
price
price_band
```

Classify products:

```text
price < 50       -> CHEAP
50 <= price <= 200 -> STANDARD
price > 200      -> PREMIUM
```

Keep all products, including inactive products.

Order by `id`.

## Interview follow-ups

- What is the difference between simple and searched CASE?
- What happens if a price is NULL?
- Could this classification be represented as a generated column?
