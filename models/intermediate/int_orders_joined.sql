with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

-- aggregate order_items to one row per order (an order can have multiple items)
order_items_agg as (
    select
        order_id,
        count(*) as num_items,
        sum(price) as total_item_price,
        sum(freight_value) as total_freight_value
    from order_items
    group by order_id
),

-- aggregate payments to one row per order (an order can have multiple payment installments)
payments_agg as (
    select
        order_id,
        sum(payment_value) as total_payment_value,
        max(payment_installments) as max_installments,
        -- take the most common payment type per order (simplification, common approach)
        array_agg(payment_type order by payment_value desc limit 1)[offset(0)] as primary_payment_type
    from payments
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_ts,
    o.order_approved_ts,
    o.order_delivered_carrier_ts,
    o.order_delivered_customer_ts,
    o.order_estimated_delivery_ts,
    oi.num_items,
    oi.total_item_price,
    oi.total_freight_value,
    p.total_payment_value,
    p.max_installments,
    p.primary_payment_type
from orders o
left join order_items_agg oi on o.order_id = oi.order_id
left join payments_agg p on o.order_id = p.order_id