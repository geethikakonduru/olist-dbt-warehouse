SELECT
    CAST(customer_id AS STRING) AS customer_id,
    CAST(customer_unique_id AS STRING) AS customer_unique_id,
    CAST(customer_city AS STRING) AS city,
    CAST(customer_state AS STRING) AS state
FROM {{ source('olist', 'customers') }}