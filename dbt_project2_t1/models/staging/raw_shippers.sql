SELECT
    shipperID,
    companyName,
    phone

from
    {{ source('raw','shippers') }}