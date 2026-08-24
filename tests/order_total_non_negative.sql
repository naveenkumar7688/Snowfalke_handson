select customer_id,
count(order_total) as total_orders_per_customer
from {{ref('staging_order_header')}}
group by customer_id
having count(order_total)<0
