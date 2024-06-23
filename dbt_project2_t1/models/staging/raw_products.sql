SELECT
    productID,
    productName,
    supplierID,
    categoryID,
    quantityPerUnit,
    unitPrice,
    unitsInStock,
    unitsOnOrder,
    reorderLevel,
    discontinued

from
    {{ source('raw','products') }}