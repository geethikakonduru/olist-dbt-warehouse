SELECT
    CAST(order_id AS STRING) AS order_id,
    CAST(order_item_id AS INT64) AS order_item_id,
    CAST(product_id AS STRING) AS product_id,
    CAST(seller_id AS STRING) AS seller_id,
    SAFE_CAST(price AS NUMERIC) AS item_price,
    SAFE_CAST(freight_value AS NUMERIC) AS freight_value
FROM {{ source('olist', 'order_items') }}