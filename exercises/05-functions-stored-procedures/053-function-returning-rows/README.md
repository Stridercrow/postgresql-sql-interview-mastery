# 053 - Function Returning Rows

## Difficulty

🟡 Medium

## Concepts

- `RETURNS TABLE`
- table-returning functions
- multiple columns in return type
- querying inside functions
- using functions in `FROM`

## Suggested Time

20 minutes

## Problem

Create a function called `get_category_products` that receives a category ID and returns all **active products** in that category.

Return:

```text
product_id
product_name
price
stock_quantity
```

Order by `price` descending, then `product_id` ascending.

## Function Signature

```sql
CREATE FUNCTION get_category_products(p_category_id BIGINT)
RETURNS TABLE (
    product_id   BIGINT,
    product_name VARCHAR(200),
    price        NUMERIC(12, 2),
    stock_quantity INTEGER
)
LANGUAGE plpgsql
```

## Examples

Using the existing seed data:

```sql
SELECT * FROM get_category_products(1);
-- Returns active Laptops: ThinkPad X1 Carbon, MacBook Air, Dell Latitude 5450
-- (Old Business Laptop is inactive, excluded)
```

## Why Table-Returning Functions Exist

A scalar function returns one value. A table-returning function returns a result set that can be used anywhere a table or subquery is expected:

```sql
-- Use the function in FROM
SELECT * FROM get_category_products(1);

-- Join the function result with other tables
SELECT c.name AS category, p.product_name, p.price
FROM categories c
JOIN get_category_products(c.id) p ON TRUE;

-- Filter further
SELECT * FROM get_category_products(2) WHERE price > 200;
```

This is useful for encapsulating reusable query logic.

## Hints

### Hint 1

Use `RETURNS TABLE` with explicit column names and types.

### Hint 2

Inside the function body, use `RETURN QUERY SELECT ...` to return rows.

### Hint 3

Filter by `active = TRUE` and `category_id = p_category_id`.

## Interview Follow-ups

- What is the difference between `RETURNS TABLE` and `SETOF record`?
- How would a Java application consume the result of this function?
- When would you prefer a view over a table-returning function?
- Could this function be replaced by a simple parameterized query in the application layer?
