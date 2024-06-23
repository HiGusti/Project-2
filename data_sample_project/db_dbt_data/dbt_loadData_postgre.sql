

--setelah database terbentuk
--1. Connect to the new database > postgresql > input host, dbname, user, password, role atau (\c dbt_project2)
--2. Create Table
--3. Test table > select
--4. load data 
--

-- 1. Create the database
CREATE DATABASE dbt_project2;

-- 2. Create table

-- Buat tabel categories
CREATE TABLE categories (
    categoryID INT PRIMARY KEY,
    categoryName VARCHAR(255),
    description text,
    picture bytea
);

-- Buat tabel customers
CREATE TABLE customers (
    customerID VARCHAR(255) PRIMARY KEY,
    companyName VARCHAR(255),
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    address_street VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(20),
    country VARCHAR(255),
    phone VARCHAR(50)
);

-- Buat tabel employees
CREATE TABLE employees (
    employeeID integer PRIMARY KEY,
    lastName varchar(255),
    firstName varchar(255),
    title varchar(255),
    titleOfCourtesy varchar(255),
    birthDate date,
    hireDate date,
    address varchar(255),
    city varchar(255),
    region varchar(255),
    postalCode varchar(10),
    country varchar(255),
    homePhone varchar(255),
    extension varchar(10),
    photo bytea,
    notes text,
    reportsTo integer,
    photoPath varchar(255)
);


-- Membuat tabel employee_territories
CREATE TABLE IF NOT EXISTS employee_territories (
    employeeID INT,
    territoryID VARCHAR(50)
);

-- Buat tabel orders
CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    customerID VARCHAR(255),
    employeeID INT,
    orderDate DATE,
    requiredDate DATE,
    shippedDate TIMESTAMP,
    shipVia INT,
    freight FLOAT,
    shipName VARCHAR(255),
    shipAddress_street VARCHAR(255),
    shipCity VARCHAR(255),
    shipRegion VARCHAR(255),
    shipPostalCode VARCHAR(20),
    shipCountry VARCHAR(255)
);

-- Buat tabel order_details (Embedded array dari orders)
CREATE TABLE order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(5, 2),
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID)
);

-- Buat tabel products
CREATE TABLE products (
    productID INT PRIMARY KEY,
    productName VARCHAR(255),
    supplierID INT,
    categoryID INT,
    quantityPerUnit VARCHAR(255),
    unitPrice FLOAT,
    unitsInStock INT,
    unitsOnOrder INT,
    reorderLevel INT,
    discontinued BOOLEAN
);

-- Buat tabel regions
CREATE TABLE regions (
    regionID INT PRIMARY KEY,
    regionDescription VARCHAR(255)
);

-- Buat tabel territories (Embedded array dari regions)
CREATE TABLE territories (
    territoryID INT,
    territoryDescription VARCHAR(255),
    regionID INT,
    PRIMARY KEY(territoryID),
    FOREIGN KEY(regionID) REFERENCES regions(regionID)
);

-- Buat tabel shippers
CREATE TABLE shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(255),
    phone VARCHAR(50)
);

-- Buat tabel suppliers
CREATE TABLE suppliers (
    supplierID INT PRIMARY KEY,
    companyName VARCHAR(100),
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    address_street VARCHAR(255),
    city VARCHAR(100),
    region VARCHAR(100),
    postalCode VARCHAR(20),
    country VARCHAR(100),
    phone VARCHAR(50),
    fax VARCHAR(50),
    homePage VARCHAR(255)
);

-- Import data dari CSV ke tabel
COPY categories (categoryID, categoryName, description, picture) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\categories.csv' 
DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.categories c 

COPY customers (customerID, companyName, contactName, contactTitle, address_street, address, city, region, postalCode, country, phone) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\customers.csv'
DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.customers c 

COPY employees(employeeID, lastName, firstName, title, titleOfCourtesy, birthDate, hireDate, address, city, region, postalCode, country, homePhone, extension, photo, notes, reportsTo, photoPath)
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\employees.csv'
DELIMITER ','
CSV HEADER;

--Query
select * from dbt_project2.public.employees e 

-- Mengimpor data dari file CSV ke tabel employee_territories
COPY employee_territories (employeeID, territoryID)
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\employee_territories.csv'
DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.employee_territories et 

COPY orders(orderID, customerID, employeeID, orderDate, requiredDate, shippedDate, shipVia, freight, shipName, shipAddress, shipCity, shipRegion, shipPostalCode, shipCountry)
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\orders.csv'
DELIMITER ','
CSV HEADER
NULL AS 'NULL';

--Query
select * from dbt_project2.public.orders o 

COPY order_details (orderID, productID, unitPrice, quantity, discount) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\order_details.csv'
DELIMITER ','
CSV HEADER;

--Query
select * from dbt_project2.public.order_details od 

COPY products (productID, productName, supplierID, categoryID, quantityPerUnit, unitPrice, unitsInStock, unitsOnOrder, reorderLevel, discontinued) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\products.csv' DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.products p 

COPY regions (regionID, regionDescription) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\regions.csv' DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.regions r 

COPY territories (territoryID, territoryDescription, regionID) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\territories.csv' DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.territories t 

COPY shippers (shipperID, companyName, phone) 
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\shippers.csv' DELIMITER ',' CSV HEADER;

--Query
select * from dbt_project2.public.shippers s 

COPY suppliers (supplierID, companyName, contactName, contactTitle, address_street, city, region, postalCode, country, phone, fax, homePage)
FROM 'D:\Training Data Engineer\project 2_test\db_dbt_data\suppliers.csv'
DELIMITER ','
CSV HEADER
NULL AS 'NULL';

--Query
select * from dbt_project2.public.suppliers s 


--NOTE TAMBAHAN PROSES

--tambahan
ALTER TABLE categories
ADD COLUMN picture BYTEA;

-- Melihat transaksi aktif
SELECT * FROM pg_stat_activity;
--Lakukan Rollback Transaksi: Jika ada transaksi sebelumnya yang gagal
ROLLBACK;
--karena table data employees salah maka drop dan buat baru
DROP TABLE dbt_project2.public.employees;

ALTER TABLE orders
    ALTER COLUMN orderDate SET DATA TYPE DATE,
    ALTER COLUMN requiredDate SET DATA TYPE DATE,
    ALTER COLUMN shippedDate SET DATA TYPE DATE;
ALTER TABLE orders
    ALTER COLUMN freight SET DATA TYPE NUMERIC(10,2);

   -- Drop kolom shipAddress_street
ALTER TABLE orders
    DROP COLUMN shipAddress_street;

-- Ganti nama kolom shipAddress_street menjadi shipAddress
ALTER TABLE orders
ADD COLUMN shipAddress VARCHAR(255);

ALTER TABLE orders
    ALTER COLUMN shippedDate SET DATA TYPE TIMESTAMP;

--
ALTER TABLE orders DROP COLUMN IF EXISTS shippedDate;
-- Menambahkan kembali kolom shippedDate dengan definisi TIMESTAMP NULL
ALTER TABLE orders
ADD COLUMN shippedDate TIMESTAMP NULL;
 
-- Mengubah tipe data unitPrice dan discount
ALTER TABLE order_details
  ALTER COLUMN unitPrice TYPE DECIMAL(10, 2),
  ALTER COLUMN discount TYPE DECIMAL(5, 2);

drop table order_details;

drop table suppliers;
   

