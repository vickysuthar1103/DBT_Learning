{% set Inc_flag = 1%}
{% set Last_load = 3%}
{% set col_list = ["sales_id", "date_sk", "net_amount"] %}

select 
    {% for col in col_list%}
        {{col}}
        {% if not loop.last %}, {% endif %}
    {% endfor %}    
from 
{{ref("bronze_sales")}} 

{% if Inc_flag == 1 %}
     where date_sk > {{Last_load}}
{% endif %}