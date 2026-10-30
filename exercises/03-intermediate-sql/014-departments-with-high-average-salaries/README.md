# 014 - Departments With High Average Salaries

## Difficulty

🟡 Medium

## Concepts

- `GROUP BY`
- `AVG`
- `HAVING`
- `WHERE` vs `HAVING`

## Problem

Find departments whose **average employee salary** is greater than `100000`.

Return:

```text
department_id
department_name
average_salary
employee_count
```

Order by `average_salary` descending.

## Think Before Coding

1. What is the result grain? (One row per department.)
2. What is the difference between filtering salary in `WHERE` vs filtering average salary in `HAVING`?
3. Why does `WHERE salary > 100000` produce a different result than `HAVING AVG(salary) > 100000`?

## `WHERE` vs `HAVING` — The Core Distinction

```sql
-- This filters INDIVIDUAL EMPLOYEES before grouping:
WHERE salary > 100000

-- This filters DEPARTMENTS after grouping:
HAVING AVG(salary) > 100000
```

`WHERE` removes rows **before** they are grouped. `HAVING` removes groups **after** aggregation.

## Expected result

There should be 3 rows.

## Interview follow-ups

1. When would you use `WHERE`?
2. When would you use `HAVING`?
3. Can `HAVING` be used without `GROUP BY`?
4. Why would filtering salary in `WHERE` produce a different result?
5. What if a department has only one employee?
