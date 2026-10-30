SELECT
    (SELECT COUNT(*) FROM customers) AS customer_count,
    (SELECT COUNT(*) FROM orders) AS order_count,
    (SELECT AVG(price) FROM products) AS average_product_price,
    (SELECT MIN(price) FROM products) AS minimum_product_price,
    (SELECT MAX(price) FROM products) AS maximum_product_price;
