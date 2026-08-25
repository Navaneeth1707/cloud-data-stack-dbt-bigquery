with source as (
    select * from `optimal-analogy-468903-h8.olist_raw.products`
)

select
    cast(product_id as string) as product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
from source