-- PostgreSQL SQL Interview Mastery
-- Complete reusable schema for the curriculum.
--
-- This file is intentionally broader than exercises 001-010.
-- Later exercises will use the additional tables.

DROP TABLE IF EXISTS user_activity CASCADE;
DROP TABLE IF EXISTS product_events CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customer_addresses CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    id          BIGSERIAL PRIMARY KEY,
    department_id BIGINT REFERENCES departments(id),
    manager_id  BIGINT REFERENCES employees(id),
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    salary      NUMERIC(12, 2) NOT NULL CHECK (salary >= 0),
    hired_at    TIMESTAMP NOT NULL
);

CREATE TABLE categories (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id              BIGSERIAL PRIMARY KEY,
    category_id     BIGINT NOT NULL REFERENCES categories(id),
    name            VARCHAR(200) NOT NULL,
    price           NUMERIC(12, 2) NOT NULL CHECK (price >= 0),
    stock_quantity  INTEGER NOT NULL DEFAULT 50 CHECK (stock_quantity >= 0),
    active          BOOLEAN NOT NULL DEFAULT TRUE,
    metadata        JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at      TIMESTAMP NOT NULL
);

CREATE TABLE customers (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    country     VARCHAR(50),
    loyalty_tier VARCHAR(20) NOT NULL DEFAULT 'BRONZE',
    created_at  TIMESTAMP NOT NULL
);

CREATE TABLE customer_addresses (
    id          BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    type        VARCHAR(20) NOT NULL CHECK (type IN ('BILLING', 'SHIPPING')),
    city        VARCHAR(100) NOT NULL,
    state       VARCHAR(100),
    postal_code VARCHAR(20),
    UNIQUE (customer_id, type)
);

CREATE TABLE orders (
    id          BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customers(id),
    status      VARCHAR(30) NOT NULL CHECK (
        status IN ('PENDING', 'PAID', 'SHIPPED', 'COMPLETED', 'CANCELLED')
    ),
    created_at  TIMESTAMP NOT NULL
);

CREATE TABLE order_items (
    id          BIGSERIAL PRIMARY KEY,
    order_id    BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id  BIGINT NOT NULL REFERENCES products(id),
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    unit_price  NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0)
);

CREATE TABLE product_events (
    id          BIGSERIAL PRIMARY KEY,
    product_id  BIGINT NOT NULL REFERENCES products(id),
    event_type  VARCHAR(50) NOT NULL,
    payload     JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at  TIMESTAMP NOT NULL
);

CREATE TABLE accounts (
    id          BIGSERIAL PRIMARY KEY,
    owner_name  VARCHAR(100) NOT NULL,
    balance     NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
    version     BIGINT NOT NULL DEFAULT 0,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_activity (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL,
    activity_date DATE NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    UNIQUE (user_id, activity_date, activity_type)
);

-- Indexes that represent normal production-oriented relational design.
-- Later performance exercises will deliberately add/remove indexes
-- or create additional datasets to investigate query plans.
CREATE INDEX idx_orders_customer_id
    ON orders(customer_id);

CREATE INDEX idx_orders_created_at
    ON orders(created_at);

CREATE INDEX idx_order_items_order_id
    ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
    ON order_items(product_id);

CREATE INDEX idx_products_category_id
    ON products(category_id);

CREATE INDEX idx_customer_addresses_customer_id
    ON customer_addresses(customer_id);

CREATE INDEX idx_product_events_product_id
    ON product_events(product_id);

CREATE INDEX idx_product_events_created_at
    ON product_events(created_at);

CREATE INDEX idx_user_activity_user_date
    ON user_activity(user_id, activity_date);
