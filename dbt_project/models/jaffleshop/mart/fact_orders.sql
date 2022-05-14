{{ config (
    materialized="table"
)}}

with customers AS (

    SELECT
        customer_id,
        first_name,
        last_name

    FROM {{ref('stg_customers')}}

),

orders AS (

    SELECT
        order_id,
        customer_id,
        order_status

    FROM {{ref('stg_orders')}}

),

payments AS (

    SELECT
        order_id,
        payment_method,
        payment_amount                     AS amount_eur

    FROM {{ref('stg_payments')}}


),
fact_orders AS (

    SELECT 
        c.customer_id,
        o.order_id,
        o.order_status,
        p.payment_method,
        SUM(p.amount_eur)               total_amount
    FROM payments p 
    JOIN orders o 
        USING (order_id)
    JOIN customers c
        USING (customer_id)
    GROUP BY 1, 2, 3, 4
)
SELECT * 
FROM fact_orders