select
    orderID,
    productID,
    unitPrice,
    quantity,
    discount

from
    {{ source('raw','order_details') }}