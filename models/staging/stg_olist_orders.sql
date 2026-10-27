WITH source AS (

    SELECT *
    FROM {{ source('olist', 'orders') }}

),

renamed AS (

    SELECT
        CAST(order_id AS STRING) AS order_id,
        CAST(customer_id AS STRING) AS customer_id,
        CAST(order_status AS STRING) AS order_status,

        SAFE_CAST(order_purchase_timestamp AS TIMESTAMP)
            AS purchased_at,

        SAFE_CAST(order_approved_at AS TIMESTAMP)
            AS approved_at,

        SAFE_CAST(order_delivered_customer_date AS TIMESTAMP)
            AS delivered_at,

        SAFE_CAST(order_estimated_delivery_date AS TIMESTAMP)
            AS estimated_delivery_at

    FROM source

)

SELECT *
FROM renamed