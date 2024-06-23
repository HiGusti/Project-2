WITH raw_order_details AS (
    SELECT * FROM {{ ref('raw_order_details') }}
),
raw_orders AS (
    SELECT * FROM {{ ref('raw_orders') }}
),
raw_employees AS (
    SELECT * FROM {{ ref('raw_employees') }}
),
raw_categories AS (
    SELECT * FROM {{ ref('raw_categories') }}
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
        CONCAT(e.firstname, ' ', e.lastname) AS employee_fullname,
        cat.categoryid,
        cat.categoryname AS category_name,
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
        raw_categories cat ON p.categoryid = cat.categoryid
    LEFT JOIN
        raw_suppliers s ON p.supplierid = s.supplierid
    LEFT JOIN
        raw_shippers shippers ON o.shipvia = shippers.shipperid
),
datamart_monthly_category_sold AS (
    SELECT
        cat.categoryname AS category_name,
        TO_CHAR(DATE_TRUNC('month', od.orderdate), 'YYYY-MM-DD') AS month, -- Mengubah format tanggal sesuai yang diharapkan
        SUM(od.quantity) AS total_quantity_sold
    FROM
        dwh_order_details od
    LEFT JOIN
        raw_products p ON od.productid = p.productid
    LEFT JOIN
        raw_categories cat ON p.categoryid = cat.categoryid
    GROUP BY
        cat.categoryname, DATE_TRUNC('month', od.orderdate)
)
SELECT
    category_name,
    month,
    total_quantity_sold
FROM
    datamart_monthly_category_sold
ORDER BY
    month, category_name