WITH orders as (
    select * from {{ ref('stg_orders') }}
),
payments as (
    select * from {{ ref('stg_payments') }}
    where payment_status in ('success')
),
final as (
    select
        orders.order_id,
        orders.customer_id,
        sum(payment_amount) as payment_amount
    from orders
    left join payments using (order_id)
    group by
    orders.order_id,
    orders.customer_id
)
select * from final