{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='order_item_key'
    )
}}

WITH items AS (
    SELECT *
    FROM {{ ref('stg_olist_order_items') }}
),

orders AS (
    SELECT *
    FROM {{ ref('stg_olist_orders') }}
),

joined AS (
    SELECT
        CONCAT(
            items.order_id, '-',
            CAST(items.order_item_id AS STRING)
        ) AS order_item_key,

        items.order_id,
        items.order_item_id,
        orders.customer_id,
        items.product_id,
        items.seller_id,
        orders.purchased_at,
        orders.order_status,
        items.item_price,
        items.freight_value,
        items.item_price + items.freight_value AS item_total

    FROM items
    INNER JOIN orders
        ON items.order_id = orders.order_id
)

SELECT *
FROM joined

{% if is_incremental() %}
WHERE NOT EXISTS (
    SELECT 1
    FROM {{ this }} AS existing
    WHERE existing.order_item_key = joined.order_item_key
)
{% endif %}