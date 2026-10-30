# 022 - Customer Ranking

## Difficulty

🟡 Medium

## Concepts

- window functions
- `RANK`
- `DENSE_RANK`
- `ROW_NUMBER`
- `OVER`
- `ORDER BY` inside `OVER`

## Problem

Rank all customers according to their **total spending**.

Return:

```text
customer_id
customer_name
total_spending
row_num
rank_num
dense_rank_num
```

- `row_num` uses `ROW_NUMBER()`
- `rank_num` uses `RANK()`
- `dense_rank_num` uses `DENSE_RANK()`

Order by `total_spending` descending, then `customer_id` ascending.

## Window Functions vs GROUP BY

```text
GROUP BY collapses rows into groups.
Window functions calculate across related rows while keeping the original rows.
```

`GROUP BY` would reduce 10 customers to groups. Window functions keep all 10 rows and add ranking columns.

## ROW_NUMBER vs RANK vs DENSE_RANK

Consider this example with tied spending:

```text
customer    spending    ROW_NUMBER    RANK    DENSE_RANK
Alice       500         1             1       1
Bob         500         2             1       1
Carol       300         3             3       2
```

- `ROW_NUMBER`: Always unique (1, 2, 3). Arbitrarily breaks ties.
- `RANK`: Same rank for ties, then skips (1, 1, 3).
- `DENSE_RANK`: Same rank for ties, no gaps (1, 1, 2).

## Expected result

There should be 10 rows.

## Interview follow-ups

- When would you use `RANK` instead of `ROW_NUMBER`?
- When would you use `DENSE_RANK` instead of `RANK`?
- How do window functions affect performance?
- Can you use `PARTITION BY` in this query? When would you?
