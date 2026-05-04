-- =============================================================
-- 04_data_quality.sql
-- Fix data quality issues found in the source dataset
--
-- Run after 03_insert_data.sql and before 05_constraints.sql
-- =============================================================

-- -------------------------------------------------------------
-- dim_product_category_name_translation
-- Two product categories in dim_products have no corresponding
-- translation in the source dataset. Inserted manually to 
-- maintain referential integrity.
-- -------------------------------------------------------------
INSERT INTO dim_product_category_name_translation 
    (product_category_name, product_category_name_english)
VALUES
    ('pc_gamer', 'pc_gamer'),
    ('portateis_cozinha_e_preparadores_de_alimentos', 'portable_kitchen_and_food_preparers');
