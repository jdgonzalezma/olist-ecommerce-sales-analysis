-- =============================================================
-- 03_insert_data.sql
-- Insert the data into the final fact and dimension tables and change the data type.
--
-- Run 04_constraints.sql after this file to create primary and foraign keys
-- =============================================================

-- =============================================================
-- orders
-- =============================================================

INSERT INTO fact_orders (
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
)
SELECT 
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp 		:: TIMESTAMP,
	order_approved_at 				:: TIMESTAMP,
	order_delivered_carrier_date 	:: TIMESTAMP,
	order_delivered_customer_date 	:: TIMESTAMP,
	order_estimated_delivery_date 	:: TIMESTAMP
FROM
	temp_fact_orders;

DROP TABLE temp_fact_orders;

-- =============================================================
-- order items
-- =============================================================

INSERT INTO fact_order_items (
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value
)
SELECT
	order_id,
	order_item_id 		:: SMALLINT,
	product_id,
	seller_id,
	shipping_limit_date :: TIMESTAMP,
	price 				:: NUMERIC(10,2),
	freight_value 		:: NUMERIC(10,2)
FROM
	temp_fact_order_items;

DROP TABLE temp_fact_order_items;

-- =============================================================
-- order payments
-- =============================================================

INSERT INTO fact_order_payments(
	order_id,
	payment_sequential,
	payment_type,
	payment_installments,
	payment_value
)
SELECT
	order_id,
	payment_sequential 	 :: SMALLINT,
	payment_type,
	payment_installments :: SMALLINT,
	payment_value 		 :: NUMERIC(10,2)
FROM
	temp_fact_order_payments;

DROP TABLE temp_fact_order_payments;

-- =============================================================
-- order reviews
-- =============================================================

INSERT INTO fact_order_reviews(
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp
)
SELECT
	review_id,
	order_id,
	review_score 			:: SMALLINT,
	review_comment_title,
	review_comment_message,
	review_creation_date 	:: TIMESTAMP,
	review_answer_timestamp :: TIMESTAMP
FROM
	temp_fact_order_reviews;

DROP TABLE temp_fact_order_reviews;

-- =============================================================
-- customers
-- =============================================================

INSERT INTO dim_customers(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
)
SELECT 
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
FROM
	temp_dim_customers;

DROP TABLE temp_dim_customers;

-- =============================================================
-- sellers
-- =============================================================

INSERT INTO dim_sellers(
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
)
SELECT
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
FROM
	temp_dim_sellers;

DROP TABLE temp_dim_sellers;

-- =============================================================
-- products
-- =============================================================

INSERT INTO dim_products(
	product_id,
	product_category_name,
	product_name_length,
	product_description_length,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm
)
SELECT
	product_id,
	product_category_name,
	product_name_lenght			 :: SMALLINT,
	product_description_lenght	 :: INTEGER,
	product_photos_qty			 :: INTEGER,
	product_weight_g			 :: INTEGER,
	product_length_cm			 :: INTEGER,
	product_height_cm			 :: INTEGER,
	product_width_cm			 :: INTEGER
FROM
	temp_dim_products;

DROP TABLE temp_dim_products;

-- =============================================================
-- geolocation
-- =============================================================

INSERT INTO dim_geolocation(
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng,
	geolocation_city,
	geolocation_state
)
SELECT
	geolocation_zip_code_prefix,
	geolocation_lat :: NUMERIC(9,6),
	geolocation_lng :: NUMERIC(9,6),
	geolocation_city,
	geolocation_state
FROM
	temp_dim_geolocation;

DROP TABLE temp_dim_geolocation;

-- =============================================================
-- category name translation
-- =============================================================

INSERT INTO dim_product_category_name_translation(
	product_category_name,
	product_category_name_english
)
SELECT
	product_category_name,
	product_category_name_english
FROM
	temp_dim_product_category_name_translation;

DROP TABLE temp_dim_product_category_name_translation;
