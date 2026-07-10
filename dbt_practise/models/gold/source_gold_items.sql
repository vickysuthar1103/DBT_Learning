with dedup_query as (
    select 
    *,
    row_number() over(partition by id order by updatedate desc) as dedup 
    from {{ source('source', 'items') }}
)
select 
    id,
    name,
    category,
    updatedate
from dedup_query
where dedup = 1