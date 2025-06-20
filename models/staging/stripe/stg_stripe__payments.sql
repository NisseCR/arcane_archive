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
        amount as amount_cents,

        -- numerics
        created::timestamp_ltz as created_at,
        case
            when
                payment_method in (
                    'stripe', 'paypal', 'credit_card', 'gift_card'
                )
                then 'credit'
            else 'cash'
        end as payment_type,

        -- booleans
        amount / 100.0 as amount,

        -- dates
        coalesce(status = 'successful', false) as is_completed_payment,

        -- timestamps
        date_trunc('day', created) as created_date

    from source

)

select * from payments
