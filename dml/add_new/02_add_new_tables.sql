# Add table names for tables that are not currently listed under table_edit schemas

insert into dictionary.`fields`
(name)

select i.table_name
from information_schema.`tables` as i

inner join dictionary.`schemas` as s 
on i.table_schema = s.name

where i.TABLE_TYPE = 'BASE TABLE'
and s.name = 'apps'
and i.table_schema not in ('mysql', 'performance_schema','information_schema')

and not exists (
	# Schema tables which already exist in dictionary
	select s.name as schema_name, t.name as table_name
	from dictionary.schemas as s
	
	inner join dictionary.schema_tables as st
	on s._id = st.schema_id
	
	inner join dictionary.`tables` as t
	on st.table_id = t._id
	
	where i.TABLE_SCHEMA = s.name
	and i.TABLE_NAME = t.name
) 
;