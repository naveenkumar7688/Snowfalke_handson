select
    customer_id,
    first_name,
    last_name,
    city,
    country,
    e_mail,
    sign_up_date
from {{ source('src_customer_loyality', 'customer_loyalty') }}
