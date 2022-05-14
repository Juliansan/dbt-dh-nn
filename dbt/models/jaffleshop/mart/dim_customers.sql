{{ config (materialized="table") }}

WITH customers AS (

    SELECT
        customer_id,
        first_name,
        last_name

    FROM {{ ref('stg_customers') }}

),

orders AS (

    SELECT
        order_id,
        customer_id,
        order_created_at,
        order_status

    FROM {{ ref('stg_orders') }}

),
payments AS (
    SELECT 
        order_id,
        payment_amount          AS life_time_value
    FROM {{ ref('stg_payments') }}
    WHERE payment_status = 'success'
),
customer_orders AS (

    SELECT
        customer_id,
        min(order_created_at)           AS first_order_date,
        max(order_created_at)           AS most_recent_order_date,
        count(order_id)                 AS number_of_orders

    FROM orders

    GROUP BY 1

),
life_time_value AS (

    SELECT 
        customer_id,
        SUM(life_time_value)             AS life_time_value
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN payments p
        ON o.order_id = p.order_id
    
    GROUP BY 1
),
dim_customers AS (

    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        COALESCE(co.number_of_orders, 0)    AS number_of_orders,
        COALESCE(ltv.life_time_value, 0)    AS ltv

    FROM customers AS c

    LEFT JOIN customer_orders AS co 
        ON c.customer_id = co.customer_id 
    LEFT JOIN life_time_value AS ltv 
        ON c.customer_id = co.customer_id

)

SELECT * FROM dim_customers;
