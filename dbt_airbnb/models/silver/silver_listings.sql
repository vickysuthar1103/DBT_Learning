{{  config(materialized = 'incremental',
    unique_key = 'LISTING_ID')
}}

select  
    LISTING_ID,
    HOST_ID,
    {{trimmer('PROPERTY_TYPE')}} AS PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMMODATES,
    BEDROOMS,
    BATHROOMS,
    {{tag('PRICE_PER_NIGHT')}} AS PRICE_TAG,
    CREATED_AT
from {{ref('bronze_listings')}}

{% if is_incremental() %}
    where CREATED_AT > (select coalesce(max(CREATED_AT), '1900-01-01') from {{ this }})
{% endif %}