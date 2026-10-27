SELECT
    DATE(purchased_at) AS order_date,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(*) AS items_sold,

    ROUND(SUM(item_price), 2)
        AS merchandise_value,

    ROUND(SUM(freight_value), 2)
        AS freight_value,

    ROUND(SUM(item_total), 2)
        AS gross_order_value

FROM {{ ref('fct_order_items') }}

WHERE order_status = 'delivered'
  AND purchased_at IS NOT NULL

GROUP BY 1