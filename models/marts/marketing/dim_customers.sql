with customers as (

    select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

orders_grouped_by_customer as (

    select
        -- ids
        customer_id,

        -- aggregated properties
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_data,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

customers_joined_on_orders as (

    select
        -- ids
        customers.customer_id,

        -- dates
        orders_grouped_by_customer.first_order_date,
        orders_grouped_by_customer.most_recent_order_data,

        -- strings
        customers.first_name,
        customers.last_name,

        -- numerics
        coalesce(orders_grouped_by_customer.number_of_orders, 0)
            as number_of_orders

    from customers

    left join orders_grouped_by_customer using (customer_id)

)

select * from customers_joined_on_orders
