select
  orderID,
  customerID,
  employeeID,
  orderDate,
  shippedDate,
  shipVia,
  shipName,
  shipCountry

from
    {{ source('raw','orders') }}