WITH raw_order_details AS (
    SELECT * FROM {{ ref('raw_order_details') }}
),
raw_orders AS (
    SELECT * FROM {{ ref('raw_orders') }}
),
raw_employees AS (
    SELECT * FROM {{ ref('raw_employees') }}
),
raw_products AS (
    SELECT * FROM {{ ref('raw_products') }}
),
raw_shippers AS (
    SELECT * FROM {{ ref('raw_shippers') }}
),
raw_suppliers AS (
    SELECT * FROM {{ ref('raw_suppliers') }}
),
dwh_order_details AS (
    SELECT
        od.orderid,
        od.productid,
        od.unitprice AS order_unitprice,
        od.quantity,
        od.discount,
        o.orderid AS orderID,
        o.orderdate,
        o.shippeddate,
        e.firstname AS employeeFirstName,  -- Menggunakan alias yang benar untuk kolom employeefirstname
        p.productname,
        p.unitprice AS product_unitprice,
        p.quantityperunit,
        p.unitsinstock,
        p.unitsonorder,
        p.reorderlevel,
        p.discontinued,
        s.companyname AS supplier_companyname,
        s.contactname AS supplier_contactname,
        s.postalcode AS supplier_postalcode,
        s.country AS supplier_country,
        s.phone AS supplier_phone
    FROM
        raw_order_details od
    JOIN
        raw_orders o ON od.orderid = o.orderid
    JOIN
        raw_employees e ON o.employeeid = e.employeeid
    JOIN
        raw_products p ON od.productid = p.productid
    LEFT JOIN
        raw_suppliers s ON p.supplierid = s.supplierid
    LEFT JOIN
        raw_shippers shippers ON o.shipvia = shippers.shipperid
),
supplier_gross_revenue AS (
    SELECT
        supplier_companyname,
        TO_CHAR(DATE_TRUNC('month', orderdate), 'YYYY-MM-DD') AS month, -- Mengubah format tanggal sesuai yang diharapkan
        SUM((order_unitprice * (1 - discount)) * quantity) AS gross_revenue
    FROM
        dwh_order_details
    GROUP BY
        supplier_companyname, DATE_TRUNC('month', orderdate)
)
SELECT
    supplier_companyname,
    month,
    gross_revenue
FROM
    supplier_gross_revenue
ORDER BY
    supplier_companyname, month