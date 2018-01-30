insert into db_data_types
(data_type)

select distinct DATA_TYPE
from information_schema.`COLUMNS`;