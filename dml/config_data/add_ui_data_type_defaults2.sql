insert into ui_data_type_defaults
(data_type)

select data_type
from db_data_types
where data_type not in (select data_type from ui_data_type_defaults);