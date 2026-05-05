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

¿Seguimos con **Data Quality Notes**?
