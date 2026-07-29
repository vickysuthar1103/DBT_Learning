{% set db = [
    {"table" : "AIRBNB.GOLD.OBT",
     "columns" : "GOLD_OBT.BOOKING_ID, GOLD_OBT.LISTING_ID, GOLD_OBT.HOST_ID,GOLD_OBT.total_amount,GOLD_OBT.accommodates, GOLD_OBT.BEDROOMS, GOLD_OBT.BATHROOMS",
     "alias" : "GOLD_OBT"},

    {"table" : "AIRBNB.GOLD.DIM_LISTINGS",
     "columns" : "",
     "alias" : "DIM_LISTINGS",
     "join_condition" : "GOLD_OBT.listing_id = DIM_LISTINGS.listing_id"},

    {"table" : "AIRBNB.GOLD.DIM_HOSTS",
     "columns" : "",
     "alias" : "DIM_HOSTS",
     "join_condition" : "GOLD_OBT.host_id = DIM_HOSTS.host_id"}
]
%}

select 
   
        {{ db[0].columns }}
from 
    {% for i in db %}
        {% if loop.first %}
            {{ i['table'] }} as {{ i['alias'] }}
        {% else %}
            left join {{ i['table'] }} as {{ i['alias'] }}
            on {{ i['join_condition'] }}
        {% endif %} 
    {% endfor %}