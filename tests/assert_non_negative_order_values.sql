SELECT
    order_item_key,
    item_price,
    freight_value,
    item_total
FROM {{ ref('fct_order_items') }}
WHERE item_price < 0
   OR freight_value < 0
   OR item_total < 0