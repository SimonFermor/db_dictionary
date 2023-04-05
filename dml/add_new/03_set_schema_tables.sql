delimiter //

CREATE PROCEDURE set_schema_tables(IN SCHEMA_NAME CHAR(25))

MODIFIES SQL DATA

BEGIN

SET @SCHEMA_NAME = SCHEMA_NAME;

insert into schema_tables
(schema_id, table_id)

select schema_id, table_id
from

(	# Tables from information_schema that are not yet in schema_tables
	# Ordering etc for use with duplication of table names, not necessary at present as only one schema
	select s._id as schema_id, i1.table_name , i2.table_schema, count(*) as row_number
	from information_schema.`tables` as i1
	
	inner join information_schema.`TABLES` as i2 
	on i1.table_name = i2.table_name
	and i1.create_time >= i2.create_time
	
	inner join dictionary.schemas as s
	on s.name = i2.table_schema
	
	where i1.TABLE_TYPE = 'BASE TABLE'
	and i2.TABLE_TYPE = 'BASE TABLE'
	
	and i1.table_schema not in ('mysql', 'performance_schema','information_schema')
	and i1.table_schema = @SCHEMA_NAME
	AND i2.TABLE_SCHEMA = @SCHEMA_NAME
	
	and not exists (
		select *
		from dictionary.`schemas` as s2
		
		inner join dictionary.`schema_tables` as x2
		on s2._id = x2.schema_id
		
		inner join dictionary.`tables` as t2
		on x2.table_id = t2._id
		
		where s2.name = i2.table_schema
		and t2.name = i1.table_name
	)
	group by i1.table_name, i2.table_schema
	order by i1.table_name, row_number
) st1

inner join

(	# Ordered list of tables not yet in schema_tables
	select t1.name as table_name, t2._id as table_id, count(*) as row_number
	from tables as t1
	
	inner join tables as t2
	on t1.name = t2.name
	and t2._id >= t1._id
	and t1._id not in (select table_id from schema_tables)
	and t2._id not in (select table_id from schema_tables)
	
	group by t1.name, t2._id
) st2

on st1.table_name = st2.table_name
and st1.row_number = st2.row_number
;

END;
//

delimiter ;