-- =============================================================
-- 06_data_cleaning.sql
-- Create a clean version of dim_geolocation with one row per zip code
--
-- Run after 05_constraints.sql
-- =============================================================

CREATE TABLE dim_geolocation_clean AS
SELECT 
    geolocation_zip_code_prefix,
    AVG(geolocation_lat)                    AS geolocation_lat,
    AVG(geolocation_lng)                    AS geolocation_lng,
    MAX(geolocation_city)                   AS geolocation_city,
    MAX(geolocation_state)                  AS geolocation_state
FROM dim_geolocation
GROUP BY geolocation_zip_code_prefix;

-- Replace original table
DROP TABLE dim_geolocation;
ALTER TABLE dim_geolocation_clean RENAME TO dim_geolocation;

-- Now PK is possible
ALTER TABLE dim_geolocation
    ADD PRIMARY KEY (geolocation_zip_code_prefix);
