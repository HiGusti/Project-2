-- File: D:\Training Data Engineer\Project\Project_2\dbt_project2_t1\models\staging\raw_customers.sql
select
    customerID as customer_id,
    companyName as company_name,
    contactName as contact_name,
    contactTitle as contact_title,
    address,
    city,
    region,
    postalCode as postal_code,
    country,
    phone
    
from
    {{ source('raw','customers') }}


-- with raw_customers as (
--     select
--         customerID as customer_id,
--         companyName as company_name,
--         contactName as contact_name,
--         contactTitle as contact_title,
--         address,
--         city,
--         region,
--         postalCode as postal_code,
--         country,
--         phone,
--         fax
--     from {{ source('project_2', 'customers') }}
-- )

-- select * from raw_customers
