-- Common Table Expressions (CTE)
WITH raw_order_details AS (
    SELECT * FROM raw_order_details
),
raw_orders AS (
    SELECT * FROM raw_orders
),
raw_employees AS (
    SELECT * FROM raw_employees
),
raw_products AS (
    SELECT * FROM raw_products
),
raw_shippers AS (
    SELECT * FROM raw_shippers
),
raw_suppliers AS (
    SELECT * FROM raw_suppliers
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
        e.firstname AS employee_firstname,
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
        DATE_TRUNC('month', od.orderdate) AS month,
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

-- Query Utama: Menampilkan hasil dalam bentuk tabel
SELECT
    category_name AS kategori_produk,
    TO_CHAR(month, 'YYYY-MM') AS bulan,
    total_quantity_sold AS jumlah_terjual
FROM
    datamart_monthly_category_sold
ORDER BY
    jumlah_terjual desc;
