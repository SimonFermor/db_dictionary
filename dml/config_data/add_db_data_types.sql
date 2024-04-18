insert into data_types
(name)

select distinct DATA_TYPE
from information_schema.`COLUMNS`;