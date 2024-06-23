with raw_categories as (
    select * from {{ ref('raw_categories') }}
),

raw_customers as (
    select * from {{ ref('raw_customers') }}
),

raw_employee_territories as (
    select * from {{ ref('raw_employee_territories') }}
),

raw_employees as (
    select * from {{ ref('raw_employees') }}
),

raw_order_details as (
    select * from {{ ref('raw_order_details') }}
),
raw_orders as (
    select * from {{ ref('raw_orders') }}
),

raw_products as (
    select * from {{ ref('raw_products') }}
),

raw_regions as (
    select * from {{ ref('raw_regions') }}
),

raw_shippers as (
    select * from {{ ref('raw_shippers') }}
),

raw_suppliers as (
    select * from {{ ref('raw_suppliers') }}
),

raw_territories as (
    select * from {{ ref('raw_territories') }}
)

SELECT
    od.orderID,
    od.productID,
    od.unitPrice AS order_unitprice,
    od.quantity,
    od.discount,
    o.orderDate,
    o.shippedDate,
    o.shipName AS ship_name,
    o.shipCountry AS ship_country,
    p.productName,
    p.unitPrice AS product_unitprice,
    p.quantityPerUnit,
    p.unitsInStock,
    p.unitsOnOrder,
    p.reorderLevel,
    p.discontinued,
    cat.categoryName AS category_name,
    s.companyName AS supplier_companyname,
    s.contactName AS supplier_contactname,
    s.postalCode AS supplier_postalcode,
    s.country AS supplier_country,
    s.phone AS supplier_phone,
    e.lastName AS employee_lastname,
    e.firstName AS employee_firstname,
    e.title AS employee_title,
    e.birthDate AS employee_birthdate,
    e.city AS employee_city,
    e.region AS employee_region,
    e.postalCode AS employee_postalcode,
    e.country AS employee_country,
    e.homePhone AS employee_homephone,
    shippers.companyName AS shipper_companyname,
    shippers.phone AS shipper_phone
FROM
    raw_order_details od
JOIN
    raw_orders o ON od.orderID = o.orderID
JOIN
    raw_products p ON od.productID = p.productID
LEFT JOIN
    raw_categories cat ON p.categoryID = cat.categoryID
LEFT JOIN
    raw_suppliers s ON p.supplierID = s.supplierID
LEFT JOIN
    raw_employees e ON o.employeeID = e.employeeID
LEFT JOIN
    raw_shippers shippers ON o.shipVia = shippers.shipperID
