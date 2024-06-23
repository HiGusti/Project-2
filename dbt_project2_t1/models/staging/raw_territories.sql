SELECT
    territoryID,
    territoryDescription,
    regionID

from
    {{ source('raw','territories') }}