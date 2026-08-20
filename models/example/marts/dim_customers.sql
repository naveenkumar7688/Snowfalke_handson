with customer_loyalty as (

    select
        customer_id,
        first_name,
        last_name,
        city,
        country,
        e_mail,
        sign_up_date
    from tasty_bytes.raw_customer.customer_loyalty

),

order_header as (

    select
        order_id,
        customer_id,
        order_ts,
        order_total
    from {{ ref('staging_order_header') }}

),

customer_orders as (

    select
        customer_id,
        count(distinct order_id) as total_orders,
        sum(order_total)         as lifetime_spend,
        min(order_ts)            as first_order_date,
        max(order_ts)            as most_recent_order_date
    from order_header
    group by customer_id

),

final as (

    select
        cl.customer_id,
        cl.first_name,
        cl.last_name,
        cl.city,
        cl.country,
        cl.e_mail,
        cl.sign_up_date,
        coalesce(co.total_orders, 0) as total_orders,
        co.lifetime_spend,
        co.first_order_date,
        co.most_recent_order_date
    from customer_loyalty cl
    left join customer_orders co
        on cl.customer_id = co.customer_id

)

select * from final