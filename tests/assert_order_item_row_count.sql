WITH source_count AS (
    SELECT COUNT(*) AS source_rows
    FROM {{ ref('stg_olist_order_items') }}
),

fact_count AS (
    SELECT COUNT(*) AS fact_rows
    FROM {{ ref('fct_order_items') }}
)

SELECT
    source_rows,
    fact_rows,
    source_rows - fact_rows AS difference

FROM source_count
CROSS JOIN fact_count

WHERE source_rows != fact_rows