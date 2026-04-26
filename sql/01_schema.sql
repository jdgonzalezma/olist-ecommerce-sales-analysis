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

-- Run this line from psql terminal:
-- \copy temp_fact_orders FROM 'your\local\path\olist_orders_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

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


CREATE TABLE temp_fact_order_items (
	order_id TEXT,
	order_item_id TEXT,
	product_id TEXT,
	seller_id TEXT,
	shipping_limit_date TEXT,
	price TEXT,
	freight_value TEXT
);

-- Run this line from psql terminal:
-- \copy temp_fact_order_items FROM 'your\local\path\olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE fact_order_items (
	order_id TEXT,
	order_item_id SMALLINT,
	product_id TEXT,
	seller_id TEXT,
	shipping_limit_date TIMESTAMP,
	price  NUMERIC(10,2),
	freight_value NUMERIC(10,2)
);

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

CREATE TABLE temp_fact_order_payments (
	order_id TEXT,
	payment_sequential TEXT,
	payment_type TEXT,
	payment_installments TEXT,
	payment_value TEXT
);

-- Run this line from psql terminal:
-- \copy temp_fact_order_payments FROM 'your\local\path\olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE fact_order_payments (
	order_id TEXT,
	payment_sequential SMALLINT,
	payment_type TEXT,
	payment_installments SMALLINT,
	payment_value NUMERIC(10,2)
);

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

CREATE TABLE temp_fact_order_reviews (
	review_id TEXT,
	order_id TEXT,
	review_score TEXT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date TEXT,
	review_answer_timestamp TEXT
);

-- Run this line from psql terminal:
-- \copy temp_fact_order_reviews FROM 'your\local\path\olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER ENCODING UTF8;

CREATE TABLE fact_order_reviews (
	review_id TEXT,
	order_id TEXT,
	review_score SMALLINT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP
);

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

CREATE TABLE temp_dim_customers (
	customer_id TEXT,
	customer_unique_id TEXT,
	customer_zip_code_prefix TEXT,
	customer_city TEXT,
	customer_state TEXT
);

-- Run this line from psql terminal:
-- \copy temp_dim_customers FROM 'your\local\path\olist_customers_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE dim_customers (
	customer_id TEXT,
	customer_unique_id TEXT,
	customer_zip_code_prefix TEXT,
	customer_city TEXT,
	customer_state TEXT
);

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

CREATE TABLE temp_dim_sellers (
	seller_id TEXT,
	seller_zip_code_prefix TEXT,
	seller_city TEXT,
	seller_state TEXT
);

-- Run this line from psql terminal:
-- \copy temp_dim_sellers FROM 'your\local\path\olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE dim_sellers(
	seller_id TEXT,
	seller_zip_code_prefix TEXT,
	seller_city TEXT,
	seller_state TEXT
);

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

-- Run this line from psql terminal:
-- \copy temp_dim_products FROM 'your\local\path\olist_products_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

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

CREATE TABLE temp_dim_geolocation (
	geolocation_zip_code_prefix TEXT,
	geolocation_lat TEXT,
	geolocation_lng TEXT,
	geolocation_city TEXT,
	geolocation_state TEXT
);

-- Run this line from psql terminal:
-- \copy temp_dim_geolocation FROM 'your\local\path\olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE dim_geolocation (
	geolocation_zip_code_prefix TEXT,
	geolocation_lat NUMERIC(9,6),
	geolocation_lng NUMERIC(9,6),
	geolocation_city TEXT,
	geolocation_state TEXT
);

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

CREATE TABLE temp_dim_product_category_name_translation (
	product_category_name TEXT,
	product_category_name_english TEXT
);

-- Run this line from psql terminal:
-- \copy temp_dim_product_category_name_translation FROM 'your\local\path\product_category_name_translation.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE dim_product_category_name_translation (
	product_category_name TEXT,
	product_category_name_english TEXT
);

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
