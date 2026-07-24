{% macro multiply(col1, col2, precision=2) %}
    round ({{col1}} * {{col2}}, {{precision}})
{% endmacro %}