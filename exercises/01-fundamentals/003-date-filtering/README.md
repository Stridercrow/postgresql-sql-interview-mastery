# 003 - Date Filtering

## Difficulty

🟢 Easy

## Concepts

- Timestamp ranges
- Inclusive/exclusive boundaries
- Date filtering

## Problem

Return all orders created during **February 2026**.

Return:

```text
id
customer_id
status
created_at
```

Order by `created_at ASC`.

Use a half-open range:

```text
>= 2026-02-01
<  2026-03-01
```

## Interview follow-ups

- Why can `>= start AND < end` be safer than `BETWEEN` for timestamps?
- What changes if `created_at` is `timestamptz`?
- How would timezone conversion affect a monthly report?
