
{% set fruits = ["apple", "banana", "cherry"] %}

--option 1: Using a for loop to iterate over the list of fruits and print each fruit
{% for fruit in fruits %}
    {% if fruit != "apple" %}
        {{- fruit -}}
    {% else %}
        i hate {{ fruit -}}
    {% endif %}
{% endfor %}

--option 2: Using a for loop to create a SQL query that selects each fruit from the list
{% for fruit in fruits %}
    SELECT '{{ fruit }}' AS fruit_name
    {% if not loop.last %} UNION ALL {% endif %}
{% endfor %}



