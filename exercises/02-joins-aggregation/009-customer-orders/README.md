# 009 - Customer Orders

## Difficulty

🟢 Easy / 🟡 Medium

## Concepts

- `INNER JOIN`
- foreign keys
- selecting columns across tables
- result ordering

## Problem

Return every customer who has at least one order.

Return:

```text
customer_id
customer_name
order_id
order_date
status
```

Order by:

```text
customer_id ASC
order_date ASC
order_id ASC
```

Do not return customers without orders.

## Interview follow-ups

- What is the difference between INNER JOIN and LEFT JOIN here?
- Could the join produce duplicate customer rows?
- What changes if we want one row per customer instead?
