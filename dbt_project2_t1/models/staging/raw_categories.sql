-- File: D:\Training Data Engineer\Project\Project_2\dbt_project2_t1\models\staging\raw_categories.sql
select
    categoryID,
    categoryName
from
    {{ source('raw','categories') }}


-- with raw_categories as (
--     select
--         categoryID as category_id,
--         categoryName as category_name,
--         description,
--         picture
--     from {{ source('project_2', 'categories') }}
-- )

-- select * from raw_categories
