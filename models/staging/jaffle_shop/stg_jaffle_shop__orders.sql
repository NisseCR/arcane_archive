with source as (

    select * from {{ source('jaffle_shop','orders') }}

),

orders as (

    select
        -- ids
        id as order_id,
        user_id as customer_id,

        -- properties
        status,
        order_date

    from source

)

select * from orders