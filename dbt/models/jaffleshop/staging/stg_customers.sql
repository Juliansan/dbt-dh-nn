
WITH src_jaffleshop_customers          AS (
    SELECT *
    FROM {{ref('src_jaffleshop_customers')}}
),
stg_customers               AS (
    SELECT *
    FROM src_jaffleshop_customers
)
SELECT * FROM stg_customers