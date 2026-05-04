-- =============================================================
-- 02_load_data.sql
-- Load CSV files into temporary tables
--
-- REQUIREMENTS:
--   - Run 01_schema.sql first
--   - Dataset downloaded from:
--     https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
--
-- HOW TO RUN:
--   psql -U your_user -d your_database -f 02_load_data.sql
--
-- Replace 'your\local\path\' with the absolute path
-- to your CSV files folder
--
-- Run 03_insert_data.sql after this file to load the CSV data
-- =============================================================
-- =============================================================

\copy temp_fact_orders FROM 'your\local\path\olist_orders_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_fact_order_items FROM 'your\local\path\olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_fact_order_payments FROM 'your\local\path\olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_fact_order_reviews FROM 'your\local\path\olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_dim_customers FROM 'your\local\path\olist_customers_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_dim_sellers FROM 'your\local\path\olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_dim_products FROM 'your\local\path\olist_products_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_dim_geolocation FROM 'your\local\path\olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
\copy temp_dim_product_category_name_translation FROM 'your\local\path\product_category_name_translation.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

