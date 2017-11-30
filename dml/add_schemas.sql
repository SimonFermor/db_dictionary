insert into table_edit.`schemas` 
(name)

select schema_name
from information_schema.schemata
where schema_name not in 
(
	select name from table_edit.schemas
);