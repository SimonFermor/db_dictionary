insert into table_edit.`tables`
(name)

select i.table_name
from information_schema.`tables` as i
inner join table_edit.`schemas` as s 
on i.table_schema = s.name
where i.TABLE_TYPE = 'BASE TABLE'
and table_schema not in ('mysql', 'perfomance_schema')
and not exists (
	select s.name as schema_name, t.name as table_name
	from table_edit.schemas as s
	inner join table_edit.schema_tables as j
	on s.id = j.schema_id
	inner join table_edit.`tables` as t
	on j.table_id = t.id
	where i.TABLE_SCHEMA = s.name
	and i.TABLE_NAME = t.name
) 
and i.table_schema = 'web'
;