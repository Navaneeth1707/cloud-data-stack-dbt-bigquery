with products as (
    select * from {{ ref('stg_products') }}
),

category_translation as (
    select * from `optimal-analogy-468903-h8.olist_raw.category_translation`
)

select
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
from products p
left join category_translation ct
    on p.product_category_name = ct.product_category_name