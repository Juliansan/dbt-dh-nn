
WITH src_jaffleshop_orders          AS (
    SELECT *
    FROM {{ref('src_jaffleshop_orders')}}
),
stg_orders               AS (
    SELECT *
    FROM src_jaffleshop_orders
)
SELECT * FROM stg_orders