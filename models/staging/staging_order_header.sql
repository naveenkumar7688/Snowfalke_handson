select
    order_id,
    customer_id,
    truck_id,
    order_ts,
    order_total
from {{ source('src_order_header', 'order_header') }}