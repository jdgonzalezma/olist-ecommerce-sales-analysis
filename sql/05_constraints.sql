-- =============================================================
-- 05_constraints.sql
-- Add primary keys and foreign keys to fact and dimension tables
--
-- Run after data_quality.sql
-- =============================================================


-- =============================================================
-- PRIMARY KEYS
-- =============================================================

ALTER TABLE fact_orders
    ADD PRIMARY KEY (order_id);

-- fact_order_reviews: review_id is not unique in the source dataset.
-- A single review_id can be associated with multiple order_id values.
-- Composite PK (review_id, order_id) is used to ensure uniqueness.
-- Verified with: SELECT review_id, order_id, COUNT(*) FROM fact_order_reviews
--               GROUP BY review_id, order_id HAVING COUNT(*) > 1

ALTER TABLE fact_order_reviews
    ADD PRIMARY KEY (review_id, order_id);

ALTER TABLE fact_order_items
    ADD PRIMARY KEY (order_id, order_item_id);

ALTER TABLE fact_order_payments
    ADD PRIMARY KEY (order_id, payment_sequential);

ALTER TABLE dim_customers
    ADD PRIMARY KEY (customer_id);

ALTER TABLE dim_sellers
    ADD PRIMARY KEY (seller_id);

ALTER TABLE dim_products
    ADD PRIMARY KEY (product_id);

ALTER TABLE dim_product_category_name_translation
    ADD PRIMARY KEY (product_category_name);

-- =============================================================
-- FOREIGN KEYS
-- =============================================================

ALTER TABLE fact_orders
    ADD CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id) REFERENCES dim_customers (customer_id);

ALTER TABLE fact_order_items
    ADD CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id) REFERENCES fact_orders (order_id),
    ADD CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id) REFERENCES dim_products (product_id),
    ADD CONSTRAINT fk_order_items_sellers
        FOREIGN KEY (seller_id) REFERENCES dim_sellers (seller_id);

ALTER TABLE fact_order_payments
    ADD CONSTRAINT fk_order_payments_orders
        FOREIGN KEY (order_id) REFERENCES fact_orders (order_id);

ALTER TABLE fact_order_reviews
    ADD CONSTRAINT fk_order_reviews_orders
        FOREIGN KEY (order_id) REFERENCES fact_orders (order_id);

ALTER TABLE dim_products
    ADD CONSTRAINT fk_products_category_translation
        FOREIGN KEY (product_category_name)
        REFERENCES dim_product_category_name_translation (product_category_name);
