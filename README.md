# PostgreSQL SQL Interview Mastery

A hands-on PostgreSQL track for experienced backend developers preparing for SQL and Java backend interviews.

The goal is **not** to memorize SQL syntax. The goal is to become comfortable solving business problems with SQL, explaining your reasoning, and eventually connecting SQL behavior to PostgreSQL performance, transactions, JDBC, and JPA/Hibernate.

## What this repository covers

The complete curriculum covers:

1. SQL fundamentals
2. Joins and aggregation
3. Subqueries and CTEs
4. Window functions
5. Classic interview patterns
6. PostgreSQL functions & stored procedures
7. Mock interview rehearsal

This repository contains:

- PostgreSQL Docker environment
- Complete reusable schema for the curriculum
- Deterministic seed data
- Exercises 001–023 (SQL fundamentals through intermediate SQL)
- Exercises 051–058 (PostgreSQL functions & stored procedures)
- Mock interview exercises (interview rehearsal)
- Solutions
- Automated SQL tests for every exercise

## Prerequisites

- Docker
- Docker Compose
- A SQL client such as `psql`, DBeaver, DataGrip, or IntelliJ IDEA
- Basic SQL knowledge

Java is **not required** for exercises 001–023.

## Quick start

Start PostgreSQL:

```bash
docker compose up -d
```

Check the container:

```bash
docker compose ps
```

Connect with `psql`:

```bash
docker exec -it sql-interview-postgres \
  psql -U interview -d interview
```

The database is initialized automatically from:

```text
database/00-create-schema.sql
database/01-seed-data.sql
```

If you change the schema or seed data and want a clean database:

```bash
docker compose down -v
docker compose up -d
```

> `down -v` deletes the PostgreSQL volume. Use it only when you want a fresh database.

## Repository structure

```text
postgresql-sql-interview-mastery/
├── README.md
├── docker-compose.yml
│
├── database/
│   ├── 00-create-schema.sql
│   └── 01-seed-data.sql
│
├── exercises/
│   ├── 01-fundamentals/
│   │   ├── 001-basic-filtering/
│   │   ├── 002-sorting-pagination/
│   │   ├── 003-date-filtering/
│   │   ├── 004-case-expressions/
│   │   ├── 005-null-handling/
│   │   ├── 006-string-functions/
│   │   ├── 007-basic-aggregation/
│   │   └── 008-order-calculation/
│   │
│   ├── 02-joins-aggregation/
│   │   ├── 009-customer-orders/
│   │   └── 010-customers-without-orders/
│   │
│   ├── 03-intermediate-sql/
│   │   ├── 011-customers-above-average-spending/
│   │   ├── 012-products-above-category-average/
│   │   ├── 013-customers-with-multiple-orders/
│   │   ├── 014-departments-with-high-average-salaries/
│   │   ├── 015-customer-spending-summary/
│   │   ├── 016-customers-who-bought-specific-product/
│   │   ├── 017-customers-who-bought-every-product-in-category/
│   │   ├── 018-products-never-purchased/
│   │   ├── 019-customer-revenue-cte/
│   │   ├── 020-monthly-revenue-report/
│   │   ├── 021-customers-with-increasing-spending/
│   │   ├── 022-customer-ranking/
│   │   └── 023-top-2-products-per-category/
│   │
│   ├── 05-functions-stored-procedures/
│   │   ├── 051-first-postgresql-function/
│   │   ├── 052-customer-spending-function/
│   │   ├── 053-function-returning-rows/
│   │   ├── 054-customer-classification-function/
│   │   ├── 055-first-stored-procedure/
│   │   ├── 056-procedure-with-validation/
│   │   ├── 057-procedure-with-multiple-table-updates/
│   │   └── 058-transactional-order-processing/
│   │
│   └── 06-interview-rehearsal/
│       ├── mock-interview-01/
│       ├── mock-interview-02/
│       └── mock-interview-03/
│
└── scripts/
    └── run-exercise.sh
```

Every exercise contains:

```text
README.md
exercise.sql
solution.sql
test.sql
```

## How to practice

For each exercise:

### 1. Read the problem

```bash
cat exercises/01-fundamentals/001-basic-filtering/README.md
```

### 2. Write your own query

Use:

```text
exercise.sql
```

Do not open `solution.sql`.

### 3. Run your query

You can paste it into `psql`, DBeaver, DataGrip, or another SQL client.

### 4. Run the official solution

Only after attempting the problem:

```bash
cat exercises/01-fundamentals/001-basic-filtering/solution.sql
```

### 5. Run the tests

```bash
./scripts/run-exercise.sh 001
```

or:

```bash
./scripts/run-exercise.sh 023
```

The test runner executes the official solution and its assertions in the same PostgreSQL session, so temporary exercise views remain available to the tests.

## Exercise progression

### Phase 1 — Fundamentals

| # | Exercise | Main concepts |
|---|---|---|
| 001 | Basic Filtering | SELECT, WHERE |
| 002 | Sorting & Pagination | ORDER BY, LIMIT, OFFSET |
| 003 | Date Filtering | timestamps, ranges |
| 004 | CASE Expressions | CASE, conditional logic |
| 005 | NULL Handling | NULL, IS NULL, COALESCE |
| 006 | String Functions | LOWER, UPPER, TRIM, SPLIT_PART |
| 007 | Basic Aggregation | COUNT, AVG, MIN, MAX |
| 008 | Order Calculation | SUM, expressions, aggregation |

### Phase 2 — Joins & aggregation

| # | Exercise | Main concepts |
|---|---|---|
| 009 | Customer Orders | INNER JOIN |
| 010 | Customers Without Orders | LEFT JOIN, anti-join |

### Phase 3 — Intermediate SQL

| # | Exercise | Main concepts |
|---|---|---|
| 011 | Customers Above Average Spending | GROUP BY, subquery, aggregate comparison |
| 012 | Products Above Category Average | correlated subquery, AVG per group |
| 013 | Customers With Multiple Orders | GROUP BY, COUNT, HAVING |
| 014 | Departments With High Average Salaries | GROUP BY, AVG, WHERE vs HAVING |
| 015 | Customer Spending Summary | LEFT JOIN, aggregation, COALESCE |
| 016 | Customers Who Bought a Specific Product | EXISTS, semi-join |
| 017 | Customers Who Bought Every Product in a Category | relational division, COUNT(DISTINCT) |
| 018 | Products Never Purchased | anti-join, LEFT JOIN IS NULL |
| 019 | Customer Revenue CTE | CTE, WITH, multi-stage queries |
| 020 | Monthly Revenue Report | DATE_TRUNC, date aggregation |
| 021 | Customers With Increasing Spending | CTE, self-join, month comparison |
| 022 | Customer Ranking | ROW_NUMBER, RANK, DENSE_RANK, OVER |
| 023 | Top 2 Products Per Category | PARTITION BY, Top-N-per-group |

### Phase 5 — Functions & Stored Procedures

| # | Exercise | Main concepts |
|---|---|---|
| 051 | First PostgreSQL Function | CREATE FUNCTION, parameters, RETURNS |
| 052 | Customer Spending Function | SELECT INTO, SUM, NULL handling |
| 053 | Function Returning Rows | RETURNS TABLE, RETURN QUERY |
| 054 | Customer Classification Function | DECLARE, IF/ELSIF/ELSE, variables |
| 055 | First Stored Procedure | CREATE PROCEDURE, CALL, UPDATE |
| 056 | Procedure With Validation | RAISE EXCEPTION, input validation |
| 057 | Procedure With Multiple Table Updates | Multi-table operations, consistency |
| 058 | Transactional Order Processing | Atomicity, validation, OUT parameters |

### Phase 6 — Interview Rehearsal

| # | Exercise | Description |
|---|---|---|
| MI-01 | High-Value Customer Report | 30 min, medium difficulty |
| MI-02 | Category Revenue Rankings | 45 min, hard difficulty |
| MI-03 | Full-Stack Backend Challenge | 60 min, SQL + JPA + Spring |

## Important interview rule

For every exercise, ask yourself:

1. What is the driving table?
2. Can the join multiply rows?
3. What happens with NULL?
4. Should the condition be in `ON` or `WHERE`?
5. What happens with duplicate values?
6. What happens when the dataset becomes large?
7. Which index might help?
8. Could this query be expressed more clearly another way?

The objective is to develop **query reasoning**, not just syntax recall.

## Database model

The reusable curriculum schema includes:

```text
customers
    │
    ├── customer_addresses
    │
    └── orders
          │
          └── order_items ── products ── categories

employees ── departments

product_events
accounts
user_activity
```

The later exercises will use these additional tables for JSONB, recursive CTEs, transactions, concurrency, and performance work.

## Resetting the environment

The database is deterministic. To reset everything:

```bash
docker compose down -v
docker compose up -d
```

## Recommended study workflow

Do not immediately solve all 50 exercises.

Use three passes:

### Pass 1 — Learn

Solve the problem without a timer.

Focus on correctness.

### Pass 2 — Master

Solve again from scratch several days later.

Try to explain the query aloud.

### Pass 3 — Interview

Set a timer:

- Easy: 5–10 minutes
- Medium: 10–20 minutes
- Hard: 20–30 minutes

Then explain:

- your approach
- edge cases
- complexity/performance considerations
- possible alternative solutions

## Target outcome

By the end of this curriculum, you should be able to comfortably handle:

```text
SELECT / WHERE / JOIN
GROUP BY / HAVING
Subqueries / CTEs
Window functions
Top-N-per-group
Gaps & islands
PostgreSQL-specific SQL
Indexes
EXPLAIN ANALYZE
Transactions
Isolation levels
Locking
JDBC / JPA / Hibernate interaction
```

The target is **senior backend interview readiness**, not database administration.
