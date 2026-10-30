# 006 - String Functions

## Difficulty

🟢 Easy

## Concepts

- `LOWER`
- `UPPER`
- `TRIM`
- `SPLIT_PART`
- string expressions

## Problem

Return every customer with:

```text
id
normalized_email
email_domain
```

Rules:

- `normalized_email` must be lowercase and trimmed.
- `email_domain` is everything after `@`.
- Order by `id`.

## Expected

All seed emails use the domain:

```text
example.test
```

## Interview follow-ups

- How would you search efficiently by email domain?
- Would an expression index help?
- How does collation affect case-insensitive comparisons?
