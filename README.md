# Ecommerce Sales Analysis

## Overview
End-to-end analysis of a Brazilian e-commerce dataset containing 100k+ orders 
from 2016 to 2018. The project covers database modeling, data ingestion, 
data quality handling, and business analysis using SQL and Python.

The goal is to extract actionable insights on sales performance, customer 
behavior, delivery efficiency, and seller activity across Brazilian states.

## Dataset

Source: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
License: CC BY-NC-SA 4.0

The dataset contains 9 CSV files covering orders placed on the Olist platform 
between 2016 and 2018. It includes information on customers, sellers, products, 
payments, deliveries, and customer reviews.

| File | Description |
|---|---|
| olist_orders_dataset.csv | Order status and timestamps |
| olist_order_items_dataset.csv | Products purchased per order |
| olist_order_payments_dataset.csv | Payment methods and values |
| olist_order_reviews_dataset.csv | Customer reviews and scores |
| olist_customers_dataset.csv | Customer location data |
| olist_sellers_dataset.csv | Seller location data |
| olist_products_dataset.csv | Product attributes and dimensions |
| olist_geolocation_dataset.csv | ZIP code coordinates |
| product_category_name_translation.csv | Category names in English |

## Project Structure

```
ecommerce-sales-analysis/
├── sql/
│   ├── 01_schema.sql            # Create fact and dimension tables
│   ├── 02_load_data.sql         # Load CSV files into temporary tables
│   ├── 03_insert_data.sql       # Cast data types and populate final tables
│   ├── 04_data_quality.sql      # Fix data quality issues from source dataset
│   ├── 05_constraints.sql       # Add primary keys and foreign keys
│   └── 06_data_cleaning.sql     # Clean dim_geolocation duplicates
├── notebooks/
│   └── 01_eda.ipynb             # Exploratory data analysis (coming soon)
├── dashboard/
│   └── olist_dashboard.pbix     # Power BI dashboard (coming soon)
└── README.md
```
## How to Run

### Requirements
- PostgreSQL 14+
- psql command-line client
- Dataset downloaded from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) and extracted to a local folder

### Steps

**1. Create a new database in PostgreSQL**
```sql
CREATE DATABASE olist;
```

**2. Update file paths in `02_load_data.sql`**  
Replace `your\local\path\` with the absolute path to the folder 
where your CSV files are located.

**3. Run the SQL files in order from the psql terminal**
```bash
psql -U your_user -d olist -f sql/01_schema.sql
psql -U your_user -d olist -f sql/02_load_data.sql
psql -U your_user -d olist -f sql/03_insert_data.sql
psql -U your_user -d olist -f sql/04_data_quality.sql
psql -U your_user -d olist -f sql/05_constraints.sql
psql -U your_user -d olist -f sql/06_data_cleaning.sql
```
## Data Quality Notes

### Duplicate review_id in fact_order_reviews
The source dataset contains duplicate `review_id` values associated with 
different `order_id` values. This appears to be a known issue in the Olist 
dataset. A composite primary key `(review_id, order_id)` was used instead 
of `review_id` alone to preserve all records while ensuring row uniqueness.

### Missing categories in dim_product_category_name_translation
Two product categories present in `dim_products` had no corresponding 
translation in the source dataset: `pc_gamer` and 
`portateis_cozinha_e_preparadores_de_alimentos`. Both were manually inserted 
into the translation table to maintain referential integrity.

### Duplicate coordinates in dim_geolocation
The geolocation table contains multiple coordinate entries per ZIP code prefix, 
making it impossible to define a primary key on `geolocation_zip_code_prefix`. 
The table was cleaned by averaging latitude and longitude values per ZIP code, 
resulting in one row per ZIP code with a valid primary key.

### Typo in dim_products source dataset
The source dataset contains a typo in two column names: `product_name_lenght` 
and `product_description_lenght`. These were corrected to `product_name_length` 
and `product_description_length` in the final table while preserving the 
original column names in the temporary loading tables.

## Analysis Questions

### Sales Performance
- What is the total revenue and number of orders per month?
- Which product categories generate the most revenue?
- What is the average order value by state?

### Customer Behavior
- What are the most common payment methods?
- What percentage of customers make more than one purchase?
- What is the average review score by product category?

### Delivery Efficiency
- What is the average delivery time by state?
- What percentage of orders are delivered before the estimated date?
- Is there a correlation between delivery time and review score?

### Seller Activity
- Which sellers generate the most revenue?
- What is the average number of orders per seller by state?

## Tools

| Tool | Purpose |
|---|---|
| PostgreSQL 14 | Database engine and SQL analysis |
| psql | Command-line client for database setup and data loading |
| Python 3 | Exploratory data analysis and data manipulation |
| pandas | Data transformation and aggregation |
| matplotlib / seaborn | Data visualization |
| Power BI | Interactive dashboard |
| Git / GitHub | Version control and project hosting |
