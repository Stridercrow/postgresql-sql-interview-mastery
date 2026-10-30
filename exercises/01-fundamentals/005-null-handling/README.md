# 005 - NULL Handling

## Difficulty

🟢 Easy

## Concepts

- `NULL`
- `IS NULL`
- `IS NOT NULL`
- `COALESCE`

## Problem

Return every customer with:

```text
id
name
country
country_display
```

Rules:

- `country_display` should be the country when present.
- If `country` is NULL, use `'Unknown'`.
- Order by `id`.

Then separately write a query that returns only customers whose country is unknown.

## Expected unknown customer

`George Martin`.

## Interview follow-ups

- Why does `country = NULL` not work?
- What does `COALESCE` return?
- What is three-valued logic?
