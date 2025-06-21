with source as (

    select * from {{ source('jaffle_shop','customers') }}

),

customers as (

    select
        -- ids
        id as customer_id,

        -- properties
        first_name,
        last_name
    
    from source

)

select * from customers
