

WITH raw_stripe_payment                  AS (
    SELECT *
    FROM {{ source('raw_jaffle_shop', 'raw_payments') }}
), 
src_stripe_payment            AS (
    SELECT 
        id                      AS payment_id,
        orderid                 AS order_id,
        paymentmethod           AS payment_method,
        status                  AS payment_status,
        amount                  AS payment_amount,
        created                 AS payment_created_at
    FROM raw_stripe_payment
)
SELECT *
FROM src_stripe_payment