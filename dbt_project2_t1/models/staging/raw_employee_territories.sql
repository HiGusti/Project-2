select
    employeeID,
    territoryID
    
from
    {{ source('raw','employee_territories') }}