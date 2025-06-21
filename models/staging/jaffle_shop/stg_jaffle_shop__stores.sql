with source as (

    select * from {{ source('jaffle_shop', 'stores') }}

),

stores as (

    select
        -- ids
        id as store_id,

        -- properties
        name as store_name,
        tax_rate,
        opened_at

    from source

)

select * from stores
