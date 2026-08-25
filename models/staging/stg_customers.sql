with source as (
    select * from `optimal-analogy-468903-h8.olist_raw.customers`
)

select
    cast(customer_id as string) as customer_id,
    cast(customer_unique_id as string) as customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from source