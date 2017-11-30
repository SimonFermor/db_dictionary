select i1.table_name , i2.table_schema, count(*) as row_number
from information_schema.`tables` as i1
inner join information_schema.`TABLES` as i2 
on i1.table_name = i2.table_name
and i1.create_time >= i2.create_time
where i1.TABLE_TYPE = 'BASE TABLE'
and i2.TABLE_TYPE = 'BASE TABLE'
and not exists (
	select *
	from table_edit.`schemas` as s2
	inner join table_edit.`schema_tables` as x2
	on s2.id = x2.schema_id
	inner join table_edit.`tables` as t2
	on x2.table_id = t2.id
	where s2.name = i1.table_schema
	and t2.name = i1.table_name
)
group by i1.table_name, i2.table_schema
order by i1.table_name

;