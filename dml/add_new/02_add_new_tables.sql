/* Add table names for tables that are not currently listed under table_edit schemas */
delimiter //

CREATE PROCEDURE add_new_tables(IN SCHEMA_NAME CHAR(25))

MODIFIES SQL DATA

BEGIN

insert into dictionary.tables
(name)

select i.table_name
from information_schema.`tables` as i

inner join dictionary.`schemas` as s 
on i.table_schema = s.name

where i.TABLE_TYPE = 'BASE TABLE'
and s.name = SCHEMA_NAME

# Exclude database schemas
and i.table_schema not in ('mysql', 'performance_schema','information_schema')

# Schema tables which already exist in dictionary
and not exists (
	select s.name as schema_name, t.name as table_name
	from dictionary.schemas as s
	
	inner join dictionary.schema_tables as st
	on s._id = st.schema_id
	
	inner join dictionary.`tables` as t
	on st.table_id = t._id
	
	where i.TABLE_SCHEMA = s.name
	and i.TABLE_NAME = t.name
)

# Table name is not waiting to be linked to schema
AND i.table_name NOT IN (
	SELECT name FROM dictionary.`tables` AS t2
	WHERE _id NOT IN (SELECT table_id FROM dictionary.schema_tables));


END;

//

delimiter ;