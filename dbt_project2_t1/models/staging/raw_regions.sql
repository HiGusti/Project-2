select
    regionID,
    regionDescription

from
    {{ source('raw','regions') }}