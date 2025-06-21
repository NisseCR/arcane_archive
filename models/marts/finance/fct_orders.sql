with

orders as (

    select * from {{ ref('stg_jaffle_shop__orders' ) }}

),

order_payments as (

    select * from {{ ref('int__payments_pivoted_to_orders') }}

),

orders_and_payments_joined as (

    select
        -- ids
        orders.order_id,
        orders.customer_id,

        -- dates
        orders.order_date,

        -- numerics
        coalesce(order_payments.total_amount, 0) as amount,
        coalesce(order_payments.gift_card_amount, 0) as gift_card_amount

    from orders

    left join order_payments using (order_id)

)

select * from orders_and_payments_joined
