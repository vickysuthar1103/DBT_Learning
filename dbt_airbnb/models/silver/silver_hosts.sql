{{  config(materialized = 'incremental',
    unique_key = 'HOST_ID')
}}

select 
    HOST_ID,
    HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    CASE WHEN RESPONSE_RATE > 90 THEN 'VERY GOOD'
        WHEN RESPONSE_RATE > 80 THEN 'GOOD'
        WHEN RESPONSE_RATE >70 THEN 'AVERAGE'
        ELSE 'BELOW AVERAGE' END AS RESPONSE_RATE_CATEGORY,
    CREATED_AT
from 
{{ ref('bronze_hosts')}}

{% if is_incremental() %}
    where CREATED_AT > (select coalesce(max(CREATED_AT), '1900-01-01') from {{ this }})
{% endif %}
