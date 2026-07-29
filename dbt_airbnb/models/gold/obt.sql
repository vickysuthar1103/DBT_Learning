{% set db = [
    {"table" : "AIRBNB.SILVER.silver_bookings",
     "columns" : "silver_booking.*",
     "alias" : "silver_booking"},

    {"table" : "AIRBNB.SILVER.silver_listings",
     "columns" : "silver_listing.property_type, silver_listing.room_type, silver_listing.city, silver_listing.country, silver_listing.accommodates, silver_listing.bedrooms, silver_listing.bathrooms, silver_listing.price_tag, silver_listing.created_at as listing_created_at",
     "alias" : "silver_listing",
     "join_condition" : "silver_booking.listing_id = silver_listing.listing_id"},

    {"table" : "AIRBNB.SILVER.silver_hosts",
     "columns" : "silver_hosts.host_id,silver_hosts.host_name, silver_hosts.host_since, silver_hosts.is_superhost, silver_hosts.response_rate_category, silver_hosts.created_at as host_created_at",
     "alias" : "silver_hosts",
     "join_condition" : "silver_listing.host_id = silver_hosts.host_id"}
]
%}

select 
    {% for i in db %}
        {{ i.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
     
from 
    {% for i in db %}
        {% if loop.first %}
            {{ i['table'] }} as {{ i['alias'] }}
        {% else %}
            left join {{ i['table'] }} as {{ i['alias'] }}
            on {{ i['join_condition'] }}
        {% endif %} 
    {% endfor %}