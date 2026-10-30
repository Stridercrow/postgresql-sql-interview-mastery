# 008 - Order Calculation

## Difficulty

🟢 Easy / 🟡 Medium

## Concepts

- `SUM`
- arithmetic expressions
- aggregation
- `GROUP BY`

## Problem

Calculate the total value of every order using:

```text
quantity * unit_price
```

Return:

```text
order_id
order_total
```

Order by `order_id`.

Important:

**Do not use `products.price`.**

The historical price for an order is stored in `order_items.unit_price`.

## Expected totals

```text
order 1 -> 1569
order 2 -> 1097
order 3 -> 1357
order 4 -> 1198
order 5 -> 149
order 6 -> 508
order 7 -> 967
order 8 -> 2148
order 9 -> 38
```

## Interview follow-ups

- Why store `unit_price` on `order_items`?
- What happens if an order has no items?
- Should money be stored as `NUMERIC` or floating point?
