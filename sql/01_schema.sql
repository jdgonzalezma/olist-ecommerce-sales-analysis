-- =============================================================
-- 01_schema.sql
-- Creates all fact and dimension tables for the Olist dataset
--
-- Run 02_load_data.sql after this file to load the CSV data
-- =============================================================

-- =============================================================
-- orders
-- =============================================================

CREATE TABLE temp_fact_orders (
	order_id TEXT,
	customer_id TEXT,
	order_status TEXT,
	order_purchase_timestamp TEXT,
	order_approved_at TEXT,
	order_delivered_carrier_date TEXT,
	order_delivered_customer_date TEXT,
	order_estimated_delivery_date TEXT
); 

CREATE TABLE fact_orders (
	order_id TEXT,
	customer_id TEXT,
	order_status TEXT,
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP
); 

-- =============================================================
-- order items
-- =============================================================

CREATE TABLE temp_fact_order_items (
	order_id TEXT,
	order_item_id TEXT,
	product_id TEXT,
	seller_id TEXT,
	shipping_limit_date TEXT,
	price TEXT,
	freight_value TEXT
);

CREATE TABLE fact_order_items (
	order_id TEXT,
	order_item_id SMALLINT,
	product_id TEXT,
	seller_id TEXT,
	shipping_limit_date TIMESTAMP,
	price  NUMERIC(10,2),
	freight_value NUMERIC(10,2)
);

-- =============================================================
-- order payments
-- =============================================================

CREATE TABLE temp_fact_order_payments (
	order_id TEXT,
	payment_sequential TEXT,
	payment_type TEXT,
	payment_installments TEXT,
	payment_value TEXT
);

CREATE TABLE fact_order_payments (
	order_id TEXT,
	payment_sequential SMALLINT,
	payment_type TEXT,
	payment_installments SMALLINT,
	payment_value NUMERIC(10,2)
);

-- =============================================================
-- order reviews
-- =============================================================

CREATE TABLE temp_fact_order_reviews (
	review_id TEXT,
	order_id TEXT,
	review_score TEXT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date TEXT,
	review_answer_timestamp TEXT
);

CREATE TABLE fact_order_reviews (
	review_id TEXT,
	order_id TEXT,
	review_score SMALLINT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP
);

-- =============================================================
-- customers
-- =============================================================

CREATE TABLE temp_dim_customers (
	customer_id TEXT,
	customer_unique_id TEXT,
	customer_zip_code_prefix TEXT,
	customer_city TEXT,
	customer_state TEXT
);

CREATE TABLE dim_customers (
	customer_id TEXT,
	customer_unique_id TEXT,
	customer_zip_code_prefix TEXT,
	customer_city TEXT,
	customer_state TEXT
);

-- =============================================================
-- sellers
-- =============================================================

CREATE TABLE temp_dim_sellers (
	seller_id TEXT,
	seller_zip_code_prefix TEXT,
	seller_city TEXT,
	seller_state TEXT
);

CREATE TABLE dim_sellers(
	seller_id TEXT,
	seller_zip_code_prefix TEXT,
	seller_city TEXT,
	seller_state TEXT
);

-- =============================================================
-- products
-- =============================================================

-- Note: 'product_name_lenght' and 'product_description_lenght' renamed
-- to correct spelling (typo present in source dataset from Kaggle)

CREATE TABLE temp_dim_products(
	product_id TEXT,
	product_category_name TEXT,
	product_name_lenght TEXT,
	product_description_lenght TEXT,
	product_photos_qty TEXT,
	product_weight_g TEXT,
	product_length_cm TEXT,
	product_height_cm TEXT,
	product_width_cm TEXT
);

CREATE TABLE dim_products(
	product_id TEXT,
	product_category_name TEXT,
	product_name_length SMALLINT,
	product_description_length INTEGER,
	product_photos_qty INTEGER,
	product_weight_g INTEGER,
	product_length_cm INTEGER,
	product_height_cm INTEGER,
	product_width_cm INTEGER
);

-- =============================================================
-- geolocation
-- =============================================================

CREATE TABLE temp_dim_geolocation (
	geolocation_zip_code_prefix TEXT,
	geolocation_lat TEXT,
	geolocation_lng TEXT,
	geolocation_city TEXT,
	geolocation_state TEXT
);

CREATE TABLE dim_geolocation (
	geolocation_zip_code_prefix TEXT,
	geolocation_lat NUMERIC(9,6),
	geolocation_lng NUMERIC(9,6),
	geolocation_city TEXT,
	geolocation_state TEXT
);

-- =============================================================
-- category name translation
-- =============================================================

CREATE TABLE temp_dim_product_category_name_translation (
	product_category_name TEXT,
	product_category_name_english TEXT
);

CREATE TABLE dim_product_category_name_translation (
	product_category_name TEXT,
	product_category_name_english TEXT
);
