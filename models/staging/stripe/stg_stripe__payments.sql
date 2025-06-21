with

source as (

    select * from {{ source('stripe','payments') }}

),

payments as (

    select
        -- ids
        id as payment_id,
        orderid as order_id,

        -- strings
        paymentmethod as payment_method,
        status,
        
        case
            when
                payment_method in (
                    'stripe', 'paypal', 'credit_card', 'gift_card'
                )
                then 'credit'
            else 'cash'
        end as payment_type,

        coalesce(status = 'successful', false) as is_completed_payment,

        -- numerics
        amount / 100.0 as amount,
        amount as amount_cents,

        -- dates
        date_trunc('day', created) as created_date,

        -- timestamps
        created::timestamp_ltz as created_at

    from source

)

select * from payments
