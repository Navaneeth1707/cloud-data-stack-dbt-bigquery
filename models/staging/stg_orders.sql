with source as (
    select * from `optimal-analogy-468903-h8.olist_raw.orders`
)

select
    cast(order_id as string) as order_id,
    cast(customer_id as string) as customer_id,
    order_status,
    cast(order_purchase_timestamp as timestamp) as order_purchase_ts,
    cast(order_approved_at as timestamp) as order_approved_ts,
    cast(order_delivered_carrier_date as timestamp) as order_delivered_carrier_ts,
    cast(order_delivered_customer_date as timestamp) as order_delivered_customer_ts,
    cast(order_estimated_delivery_date as timestamp) as order_estimated_delivery_ts
from source