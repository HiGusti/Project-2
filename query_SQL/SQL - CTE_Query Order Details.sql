-- Define the CTE to fetch detailed order information
WITH order_details_cte AS (
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
        project_2.raw_order_details od
    JOIN
        project_2.raw_orders o ON od.orderID = o.orderID
    JOIN
        project_2.raw_products p ON od.productID = p.productID
    LEFT JOIN
        project_2.raw_categories cat ON p.categoryID = cat.categoryID
    LEFT JOIN
        project_2.raw_suppliers s ON p.supplierID = s.supplierID
    LEFT JOIN
        project_2.raw_employees e ON o.employeeID = e.employeeID
    LEFT JOIN
        project_2.raw_shippers shippers ON o.shipVia = shippers.shipperID
)

-- Final SELECT statement to output the CTE results
SELECT * FROM order_details_cte;
