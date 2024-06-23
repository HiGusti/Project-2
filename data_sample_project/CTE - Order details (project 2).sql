WITH order_details_cte AS (
    SELECT
        od.orderID,
        od.productID,
        od.unitPrice,
        od.quantity,
        od.discount,
        o.orderDate,
        o.requiredDate,
        o.shippedDate,
        o.freight,
        o.shipName,
        o.shipCity,
        o.shipRegion,
        o.shipPostalCode,
        o.shipCountry,
        p.productName,
        p.unitPrice AS productUnitPrice,
        p.quantityPerUnit,
        p.unitsInStock,
        p.unitsOnOrder,
        p.reorderLevel,
        p.discontinued,
        c.categoryName,
        c.description AS categoryDescription,
        s.companyName AS supplierCompanyName,
        s.contactName AS supplierContactName,
        s.contactTitle AS supplierContactTitle,
        s.address_street AS supplierAddress,
        s.city AS supplierCity,
        s.region AS supplierRegion,
        s.postalCode AS supplierPostalCode,
        s.country AS supplierCountry,
        s.phone AS supplierPhone,
        e.lastName AS employeeLastName,
        e.firstName AS employeeFirstName,
        e.title AS employeeTitle,
        e.titleOfCourtesy AS employeeTitleOfCourtesy,
        e.birthDate AS employeeBirthDate,
        e.hireDate AS employeeHireDate,
        e.address AS employeeAddress,
        e.city AS employeeCity,
        e.region AS employeeRegion,
        e.postalCode AS employeePostalCode,
        e.country AS employeeCountry,
        e.homePhone AS employeeHomePhone,
        e.extension AS employeeExtension
    FROM
        order_details od
    JOIN
        orders o ON od.orderID = o.orderID
    JOIN
        products p ON od.productID = p.productID
    LEFT JOIN
        categories c ON p.categoryID = c.categoryID
    LEFT JOIN
        suppliers s ON p.supplierID = s.supplierID
    LEFT JOIN
        employees e ON o.employeeID = e.employeeID
)
SELECT * FROM order_details_cte;
