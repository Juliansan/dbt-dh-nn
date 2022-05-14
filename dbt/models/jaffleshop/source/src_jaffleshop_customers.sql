

WITH raw_customers                  AS (
    SELECT *
    FROM {{ source('raw_jaffle_shop', 'raw_customers') }}
), 
src_jaffleshop_customers            AS (
    SELECT 
        id                      AS customer_id,
        first_name,
        last_name
    FROM raw_customers
)
SELECT *
FROM src_jaffleshop_customers