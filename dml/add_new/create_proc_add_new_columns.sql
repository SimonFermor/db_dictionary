/* Add new columns - names are considered to relate to the same data irrespective of source table... */

delimiter //

CREATE PROCEDURE add_new_columns(IN SCHEMA_NAME CHAR(25), IN TABLE_NAME CHAR(25))

MODIFIES SQL DATA

BEGIN

SET @SCHEMA_NAME = SCHEMA_NAME;
SET @TABLE_NAME = TABLE_NAME;

insert into dictionary.columns 
(name, data_type_id)

SELECT i.COLUMN_NAME, d._id
from information_schema.`COLUMNS` as i

INNER JOIN data_types AS d
ON i.DATA_TYPE = d.name

where i.table_schema not in ('mysql', 'performance_schema','information_schema')

and i.table_schema = @SCHEMA_NAME
and i.TABLE_NAME = @TABLE_NAME

and not exists
(	select *
	from dictionary.schemas as s
		
	inner join dictionary.schema_tables as st
	on s._id = st.schema_id
		
	inner join dictionary.tables as t
	on st.table_id = t._id
		
	inner join dictionary.table_columns tc
	on t._id = tc.table_id
		
	inner join dictionary.columns as c
	on tc.column_id = c._id
	
	where s.name = i.TABLE_SCHEMA
	and t.name = i.TABLE_NAME
	and c.name = i.COLUMN_NAME
);

END;
//

delimiter ;