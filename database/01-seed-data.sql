-- Deterministic seed data for exercises 001-010 and later curriculum work.

INSERT INTO departments (name) VALUES
    ('Engineering'),
    ('Product'),
    ('Sales'),
    ('Finance');

INSERT INTO employees (department_id, manager_id, name, email, salary, hired_at) VALUES
    (1, NULL, 'Alice Johnson', 'alice@company.test', 150000, '2020-01-15'),
    (1, 1, 'Bob Smith', 'bob@company.test', 120000, '2021-03-10'),
    (1, 1, 'Carol Davis', 'carol@company.test', 120000, '2022-06-01'),
    (1, 2, 'David Wilson', 'david@company.test', 95000, '2023-02-20'),
    (2, NULL, 'Eva Martinez', 'eva@company.test', 135000, '2020-05-11'),
    (2, 5, 'Frank Moore', 'frank@company.test', 105000, '2022-08-19'),
    (3, NULL, 'Grace Taylor', 'grace@company.test', 110000, '2019-11-04'),
    (3, 7, 'Henry Anderson', 'henry@company.test', 85000, '2023-01-09'),
    (4, NULL, 'Ivy Thomas', 'ivy@company.test', 130000, '2021-09-13');

INSERT INTO categories (name) VALUES
    ('Laptops'),
    ('Monitors'),
    ('Keyboards'),
    ('Mice'),
    ('Networking');

INSERT INTO products (category_id, name, price, stock_quantity, active, metadata, created_at) VALUES
    (1, 'ThinkPad X1 Carbon', 1450.00, 25, TRUE,  '{"brand":"Lenovo","source":"web"}', '2026-01-05 09:00:00'),
    (1, 'MacBook Air', 1299.00, 40, TRUE, '{"brand":"Apple","source":"mobile"}', '2026-01-10 10:00:00'),
    (1, 'Dell Latitude 5450', 999.00, 35, TRUE, '{"brand":"Dell","source":"web"}', '2026-01-15 11:00:00'),
    (1, 'Old Business Laptop', 650.00, 0, FALSE, '{"brand":"Dell","source":"legacy"}', '2025-10-10 08:00:00'),
    (2, 'Dell UltraSharp 27', 499.00, 30, TRUE, '{"brand":"Dell","resolution":"4K"}', '2026-01-20 12:00:00'),
    (2, 'LG 27GP850', 449.00, 20, TRUE, '{"brand":"LG","resolution":"QHD"}', '2026-01-21 12:30:00'),
    (2, 'Budget 24 Monitor', 149.00, 50, TRUE, '{"brand":"Generic","resolution":"FHD"}', '2026-01-22 13:00:00'),
    (3, 'Keychron Q1', 199.00, 15, TRUE, '{"brand":"Keychron","layout":"ANSI"}', '2026-01-25 14:00:00'),
    (3, 'Logitech MX Keys', 119.00, 40, TRUE, '{"brand":"Logitech","layout":"ANSI"}', '2026-01-26 14:30:00'),
    (3, 'Basic Keyboard', 29.00, 100, TRUE, '{"brand":"Generic"}', '2026-01-27 15:00:00'),
    (4, 'Logitech MX Master 3S', 99.00, 25, TRUE, '{"brand":"Logitech","connection":"bluetooth"}', '2026-01-28 16:00:00'),
    (4, 'Razer DeathAdder', 69.00, 30, TRUE, '{"brand":"Razer","connection":"usb"}', '2026-01-29 16:00:00'),
    (4, 'Basic Mouse', 19.00, 80, TRUE, '{"brand":"Generic"}', '2026-01-30 16:30:00'),
    (5, 'UniFi Dream Machine', 379.00, 10, TRUE, '{"brand":"Ubiquiti","wifi":"6"}', '2026-02-01 09:00:00'),
    (5, 'TP-Link AX55', 129.00, 45, TRUE, '{"brand":"TP-Link","wifi":"6"}', '2026-02-02 09:30:00'),
    (5, 'Old Router', 49.00, 0, FALSE, '{"brand":"Generic","source":"legacy"}', '2025-11-01 09:00:00');

INSERT INTO customers (name, email, country, loyalty_tier, created_at) VALUES
    ('Adrian Baker', 'adrian@example.test', 'Mexico', 'GOLD', '2025-01-10 09:00:00'),
    ('Beatriz Garcia', 'beatriz@example.test', 'Mexico', 'SILVER', '2025-02-12 10:00:00'),
    ('Carlos Hernandez', 'carlos@example.test', 'Mexico', 'SILVER', '2025-03-20 11:00:00'),
    ('Diana Lopez', 'diana@example.test', 'Spain', 'GOLD', '2025-04-01 12:00:00'),
    ('Ethan Brown', 'ethan@example.test', 'United States', 'BRONZE', '2025-05-05 13:00:00'),
    ('Fatima Ali', 'fatima@example.test', 'Canada', 'BRONZE', '2025-06-10 14:00:00'),
    ('George Martin', 'george@example.test', NULL, 'BRONZE', '2025-07-15 15:00:00'),
    ('Hannah Wilson', 'hannah@example.test', 'United Kingdom', 'BRONZE', '2025-08-20 16:00:00'),
    ('Ivan Petrov', 'ivan@example.test', 'Germany', 'BRONZE', '2025-09-25 17:00:00'),
    ('Julia Rossi', 'julia@example.test', 'Italy', 'BRONZE', '2025-10-30 18:00:00');

INSERT INTO customer_addresses (customer_id, type, city, state, postal_code) VALUES
    (1, 'BILLING', 'Mexico City', 'CDMX', '01000'),
    (1, 'SHIPPING', 'Mexico City', 'CDMX', '01000'),
    (2, 'BILLING', 'Guadalajara', 'Jalisco', '44100'),
    (2, 'SHIPPING', 'Guadalajara', 'Jalisco', '44100'),
    (3, 'BILLING', 'Monterrey', 'Nuevo Leon', '64000'),
    (4, 'BILLING', 'Madrid', 'Madrid', '28001'),
    (5, 'BILLING', 'Austin', 'Texas', '73301'),
    (6, 'BILLING', 'Toronto', 'Ontario', 'M5V 1A1');

-- Deliberately includes customers with no orders: 6, 7, 8, 9, 10.
INSERT INTO orders (customer_id, status, created_at) VALUES
    (1, 'COMPLETED', '2026-01-05 10:00:00'),
    (1, 'COMPLETED', '2026-01-15 11:00:00'),
    (1, 'SHIPPED',   '2026-02-10 12:00:00'),
    (2, 'COMPLETED', '2026-01-20 13:00:00'),
    (2, 'CANCELLED', '2026-02-05 14:00:00'),
    (3, 'PAID',      '2026-02-12 15:00:00'),
    (3, 'COMPLETED', '2026-03-01 16:00:00'),
    (4, 'COMPLETED', '2026-03-10 17:00:00'),
    (5, 'PENDING',   '2026-03-15 18:00:00');

-- Exercise 017 requires at least one customer who bought every product
-- in a category. Beatriz Garcia (customer 2) bought all Keyboards:
-- products 8 (Keychron Q1), 9 (Logitech MX Keys), 10 (Basic Keyboard).
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 1, 1450.00),
    (1, 9, 1, 119.00),
    (2, 5, 2, 499.00),
    (2, 11, 1, 99.00),
    (3, 2, 1, 1299.00),
    (3, 10, 2, 29.00),
    (4, 3, 1, 999.00),
    (4, 8, 1, 199.00),
    (4, 9, 1, 119.00),
    (4, 10, 1, 29.00),
    (5, 7, 1, 149.00),
    (6, 14, 1, 379.00),
    (6, 15, 1, 129.00),
    (7, 6, 2, 449.00),
    (7, 12, 1, 69.00),
    (8, 1, 1, 1450.00),
    (8, 5, 1, 499.00),
    (8, 8, 1, 199.00),
    (9, 13, 2, 19.00);

INSERT INTO product_events (product_id, event_type, payload, created_at) VALUES
    (1, 'VIEWED', '{"source":"web","campaign":"spring"}', '2026-03-01 09:00:00'),
    (1, 'PURCHASED', '{"source":"web","campaign":"spring"}', '2026-03-02 10:00:00'),
    (2, 'VIEWED', '{"source":"mobile","campaign":"summer","device":{"os":"ios"}}', '2026-03-03 11:00:00'),
    (5, 'VIEWED', '{"source":"mobile","campaign":"summer","device":{"os":"android"}}', '2026-03-04 12:00:00');

INSERT INTO accounts (owner_name, balance, version) VALUES
    ('Account A', 1000.00, 0),
    ('Account B', 500.00, 0),
    ('Account C', 250.00, 0);

INSERT INTO user_activity (user_id, activity_date, activity_type) VALUES
    (1, '2026-01-01', 'LOGIN'),
    (1, '2026-01-02', 'LOGIN'),
    (1, '2026-01-03', 'LOGIN'),
    (1, '2026-01-07', 'LOGIN'),
    (2, '2026-01-01', 'LOGIN'),
    (2, '2026-01-03', 'LOGIN'),
    (2, '2026-01-04', 'LOGIN'),
    (2, '2026-01-05', 'LOGIN');
