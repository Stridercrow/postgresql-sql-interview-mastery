# Exercises 051–058 — PostgreSQL Functions & Stored Procedures

This section develops practical PL/pgSQL skills required during technical interviews. You will write PostgreSQL functions, stored procedures, and learn to reason about transaction behavior, validation, and error handling.

## Why This Section Matters

PostgreSQL functions and stored procedures are frequently tested in backend interviews. The key skills are:

- Writing functions that accept parameters and return values
- Querying tables from inside functions
- Using `SELECT INTO` to capture query results into variables
- Writing table-returning functions
- Implementing conditional logic with `IF / ELSIF / ELSE`
- Creating stored procedures with `CREATE PROCEDURE`
- Invoking procedures with `CALL`
- Validating input and raising meaningful errors
- Performing multi-table operations atomically
- Understanding the difference between functions and procedures
- Connecting database-side logic to Java/Spring patterns

## Exercises

| # | Topic | Difficulty | Time |
|---|---|---|---|
| 051 | First PostgreSQL Function | 🟢 Easy | 10–15 min |
| 052 | Customer Spending Function | 🟡 Medium | 15–20 min |
| 053 | Function Returning Rows | 🟡 Medium | 20 min |
| 054 | Customer Classification Function | 🟡 Medium | 20 min |
| 055 | First Stored Procedure | 🟡 Medium | 20–25 min |
| 056 | Procedure With Validation | 🟡 Medium | 25–30 min |
| 057 | Procedure With Multiple Table Updates | 🔴 Hard | 30–40 min |
| 058 | Transactional Order Processing | 🔴 Hard | 45–60 min |

## Function vs Procedure — Quick Reference

```text
FUNCTION
    └── RETURNS a value (scalar or table)
    └── can be used in SQL expressions: SELECT my_func(...)
    └── cannot control transactions (no COMMIT/ROLLBACK)

PROCEDURE
    └── invoked with CALL: CALL my_proc(...)
    └── can contain COMMIT / ROLLBACK
    └── does not return a value directly (use OUT parameters or side effects)
```

PostgreSQL-specific rules:

1. A function declared `RETURNS TABLE` or `SETOF` can be used in `FROM`.
2. A function without `RETURNS` is a procedure — but in PostgreSQL, use `CREATE PROCEDURE` explicitly.
3. Only procedures can call `COMMIT` or `ROLLBACK` inside their body.
4. Functions can modify data (INSERT/UPDATE/DELETE) but cannot manage transactions.

## How to Practice

Same workflow as previous exercises:

1. Read `README.md` for the problem
2. Write your implementation in `exercise.sql`
3. Run it against the database
4. Compare with `solution.sql`
5. Run the automated tests with `./scripts/run-exercise.sh <number>`

For stored procedures and functions, the test runner will:

1. Execute `solution.sql` (which creates the function/procedure)
2. Execute `test.sql` (which calls the function/procedure and asserts results)

The solution file uses `DROP ... IF EXISTS` before creating the object, so repeated runs are safe.
