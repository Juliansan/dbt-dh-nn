

WITH raw_orders                  AS (
    SELECT *
    FROM {{ source('raw_jaffle_shop', 'raw_orders') }}
), 
src_jaffleshop_orders            AS (
    SELECT 
        id                      AS order_id,
        user_id                 AS customer_id,
        order_date              AS order_created_at,
        status                  AS order_status
    FROM raw_orders
)
SELECT *
FROM src_jaffleshop_orders