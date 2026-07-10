with sales as (
    select 
    sales_id,
    product_sk,
    customer_sk,
    {{ multiply('unit_price', 'quantity') }} as total_amount
    from
        {{ ref("bronze_sales")}}
),
product as(
    select 
    product_sk,
    product_name,
    category
    from
        {{ ref("bronze_product")}}
) ,
customer as(
    select 
    customer_sk,
    gender
    from
        {{ ref("bronze_customer")}}
),
joined_query as (
select 
    s.sales_id,
    p.product_name,
    p.category,
    c.gender,
    s.total_amount
from 
    sales s
    left join product p on s.product_sk = p.product_sk
    left join customer c on s.customer_sk = c.customer_sk
)
select 
    category,
    gender,
    sum(total_amount) as total_sales 
from 
joined_query
group by 
    category,
    gender
order by category