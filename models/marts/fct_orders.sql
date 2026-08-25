with orders_joined as (
    select * from {{ ref('int_orders_joined') }}
)

select
    order_id,
    customer_id,
    order_status,
    order_purchase_ts,
    order_approved_ts,
    order_delivered_carrier_ts,
    order_delivered_customer_ts,
    order_estimated_delivery_ts,
    num_items,
    total_item_price,
    total_freight_value,
    total_payment_value,
    max_installments,
    primary_payment_type,
    -- derived metric: delivery delay in days (positive = late, negative = early)
    date_diff(
        date(order_delivered_customer_ts),
        date(order_estimated_delivery_ts),
        day
    ) as delivery_delay_days
from orders_joined
where order_status = 'delivered'