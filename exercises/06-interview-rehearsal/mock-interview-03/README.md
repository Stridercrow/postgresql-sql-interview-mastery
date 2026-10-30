# Mock Interview 03 — Full-Stack Backend Challenge

## Time Limit

60 minutes

## Difficulty

🔴 Hard

## Business Scenario

You are a senior backend developer. The product manager sends you this requirement:

> "I need a report showing, for each customer, their total spending, the number of distinct products they purchased, their most recent order date, and a spending tier (HIGH if spending > 2000, MEDIUM if > 500, LOW otherwise). Only include customers who have placed at least one order. Order by total spending descending."

## Part 1 — PostgreSQL Solution (30 minutes)

Write the SQL query.

### Available Tables

```text
customers (id, name, email, country, loyalty_tier, created_at)
orders (id, customer_id, status, created_at)
order_items (id, order_id, product_id, quantity, unit_price)
products (id, category_id, name, price, ...)
```

### Requirements

Return:

```text
customer_name
total_spending
distinct_products
last_order_date
spending_tier
```

Only include customers with at least one order (any status). Order by `total_spending` descending.

## Part 2 — JPA/JPQL Discussion (15 minutes)

After writing the SQL, answer these questions:

1. **Could you rewrite this query using JPQL?** What would be the JPQL equivalent?
2. **When would you choose JPQL over native SQL?**
3. **When would you choose native SQL over JPQL?**
4. **How would this query be implemented in a Spring service?** Describe the layers.
5. **What N+1 problem risks exist if you fetch this data naively with JPA?**

## Part 3 — Stored Procedure Extension (15 minutes, optional)

Write a stored procedure called `get_customer_report` that:

1. Accepts a `p_min_spending` parameter (default 0).
2. Returns the same result set as Part 1, but only for customers with `total_spending >= p_min_spending`.
3. Uses a `RETURN QUERY` table-returning function or a procedure with a cursor.

Discuss: **When would you use a stored procedure for reporting instead of a repository query?**

## Hints (use only if stuck)

### Hint 1 (Part 1)

Join `customers → orders → order_items`. Use `GROUP BY` with aggregate functions.

### Hint 2 (Part 1)

Use a `CASE` expression for the spending tier:

```sql
CASE
    WHEN SUM(...) > 2000 THEN 'HIGH'
    WHEN SUM(...) > 500  THEN 'MEDIUM'
    ELSE 'LOW'
END
```

### Hint 3 (Part 1)

`COUNT(DISTINCT oi.product_id)` gives you distinct products.

## Expected Result (Part 1)

```text
customer_name     total_spending  distinct_products  last_order_date   spending_tier
────────────────────────────────────────────────────────────────────────────────────
Adrian Baker      4023.00         6                  2026-02-10        HIGH
Diana Lopez       2148.00         3                  2026-03-10        HIGH
Beatriz Garcia    1495.00         5                  2026-02-05        MEDIUM
Carlos Hernandez  1475.00         4                  2026-03-01        MEDIUM
Ethan Brown       38.00           1                  2026-03-15        LOW
```

## Interview Discussion Points

After completing all parts, be prepared to discuss:

1. **JPQL vs Native SQL**: When is each appropriate?
2. **@Transactional behavior**: How does Spring manage transactions when calling a stored procedure?
3. **Performance**: How would you index this query?
4. **Scalability**: What happens with 10 million orders?
5. **Testing**: How would you write a unit test for this service method?
6. **DDD perspective**: Should spending tier calculation live in the database or the domain model?

## Reference: JPQL Equivalent

```java
@Query("""
    SELECT c.name, SUM(oi.quantity * oi.unitPrice), COUNT(DISTINCT oi.product.id), MAX(o.createdAt)
    FROM Customer c
    JOIN c.orders o
    JOIN o.orderItems oi
    GROUP BY c.id, c.name
    ORDER BY SUM(oi.quantity * oi.unitPrice) DESC
""")
List<Object[]> getCustomerReport();
```

Note: JPQL does not support `CASE` expressions in the same way SQL does. The spending tier would need to be computed in Java.
