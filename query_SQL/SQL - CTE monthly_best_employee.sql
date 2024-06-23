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
dwh_order_details AS (
    SELECT
        od.orderid,
        od.productid,
        od.unitprice AS order_unitprice,
        od.quantity,
        od.discount,
        o.orderdate,
        e.employeeid,
        CONCAT(e.firstname, ' ', e.lastname) AS employee_fullname
    FROM
        raw_order_details od
    JOIN
        raw_orders o ON od.orderid = o.orderid
    JOIN
        raw_employees e ON o.employeeid = e.employeeid
),
employee_monthly_revenue AS (
    SELECT
        employee_fullname,
        DATE_TRUNC('month', orderdate) AS month,
        SUM(order_unitprice * quantity * (1 - discount)) AS total_gross_revenue
    FROM
        dwh_order_details
    GROUP BY
        employee_fullname, DATE_TRUNC('month', orderdate)
),
best_employee AS (
    SELECT
        month,
        employee_fullname,
        total_gross_revenue,
        RANK() OVER (PARTITION BY month ORDER BY total_gross_revenue DESC) AS revenue_rank
    FROM
        employee_monthly_revenue
)
-- Query Utama: Menampilkan hasil dalam bentuk tabel
SELECT
    employee_fullname AS best_employee_name,
    TO_CHAR(month, 'YYYY-MM-DD') AS month,
    total_gross_revenue
FROM
    best_employee
WHERE
    revenue_rank = 1
ORDER BY
    month, best_employee_name;
