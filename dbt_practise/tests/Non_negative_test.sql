select 
    *
From
    
    {{ ref('bronze_sales') }}
Where
    gross_amount < 0 and net_amount < 0