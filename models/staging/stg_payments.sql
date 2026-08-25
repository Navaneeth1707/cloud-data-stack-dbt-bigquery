with source as (
    select * from `optimal-analogy-468903-h8.olist_raw.payments`
)

select
    cast(order_id as string) as order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
from source