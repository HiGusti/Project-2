SELECT
    supplierID,
    companyName,
    contactName,
    postalCode,
    country,
    phone

from
    {{ source('raw','suppliers') }}