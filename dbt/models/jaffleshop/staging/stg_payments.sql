
WITH src_stripe_payments          AS (
    SELECT *
    FROM {{ref('src_stripe_payments')}}
),
stg_payments               AS (
    SELECT 
        payment_id,
        order_id,
        payment_method,
        payment_status,
        payment_amount / 100        AS payment_amount,
        payment_created_at

    FROM src_stripe_payments
)
SELECT * FROM stg_payments