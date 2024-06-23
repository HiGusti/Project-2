select
    employeeID,
    lastName,
    firstName,
    title,
    birthDate,
    city,
    region,
    postalCode,
    country,
    homePhone
    
from
    {{ source('raw','employees') }}