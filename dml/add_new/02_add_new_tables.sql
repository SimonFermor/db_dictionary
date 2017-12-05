# Add table names for tables that are not currently listed under table_edit schemas

insert into table_edit.`tables`
(name)

select i.table_name
from information_schema.`tables` as i

inner join table_edit.`schemas` as s 
on i.table_schema = s.name

where i.TABLE_TYPE = 'BASE TABLE'
and i.table_schema not in ('mysql', 'performance_schema','information_schema')
and not exists (
	# Schema tables which already exist in table edit
	select s.name as schema_name, t.name as table_name
	from table_edit.schemas as s
	inner join table_edit.schema_tables as st
	on s.id = st.schema_id
	inner join table_edit.`tables` as t
	on st.table_id = t.id
	where i.TABLE_SCHEMA = s.name
	and i.TABLE_NAME = t.name
) 
;