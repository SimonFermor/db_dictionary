insert into schema_tables
(schema_id, table_id)

select schema_id, table_id
from

(	# Tables from information_schema that are not yet in schema_tables
	# Ordering etc for use with duplication of table names, not necessary at present as only one schema
	select s.id as schema_id, i1.table_name , i2.table_schema, count(*) as row_number
	from information_schema.`tables` as i1
	
	inner join information_schema.`TABLES` as i2 
	on i1.table_name = i2.table_name
	and i1.create_time >= i2.create_time
	
	inner join table_edit.schemas as s
	on s.name = i2.table_schema
	
	where i1.TABLE_TYPE = 'BASE TABLE'
	and i2.TABLE_TYPE = 'BASE TABLE'
	
	and i1.table_schema not in ('mysql', 'performance_schema','information_schema')
	and i1.table_schema = 'apps'
	
	and not exists (
		select *
		from table_edit.`schemas` as s2
		
		inner join table_edit.`schema_tables` as x2
		on s2.id = x2.schema_id
		
		inner join table_edit.`tables` as t2
		on x2.table_id = t2.id
		
		where s2.name = i2.table_schema
		and t2.name = i1.table_name
	)
	group by i1.table_name, i2.table_schema
	order by i1.table_name, row_number
) st1

inner join

(	# Ordered list of tables not yet in schema_tables
	select t1.name as table_name, t2.id as table_id, count(*) as row_number
	from tables as t1
	
	inner join tables as t2
	on t1.name = t2.name
	and t2.id >= t1.id
	and t1.id not in (select table_id from schema_tables)
	and t2.id not in (select table_id from schema_tables)
	
	group by t1.name, t2.id
) st2

on st1.table_name = st2.table_name
and st1.row_number = st2.row_number
;