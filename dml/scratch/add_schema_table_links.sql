insert into table_edit.schema_tables
(schema_id, table_id)

select s.id as schema_id, t.id as table_id
from information_schema.`tables` as i

inner join table_edit.`schemas` as s 
on i.table_schema = s.name

inner join table_edit.`tables` as t 
on i.table_name = t.name

where i.TABLE_TYPE = 'BASE TABLE'
and table_schema not in ('mysql', 'perfomance_schema', 'test')
and not exists (
	select *
	from table_edit.`schemas` as s2
	inner join table_edit.`schema_tables` as x2
	on s2.id = x2.schema_id
	inner join table_edit.`tables` as t2
	on x2.table_id = t2.id
	where s2.name = i.table_schema
	and t2.name = i.table_name
)
and s.name = 'web'
;