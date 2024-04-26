/* Add new column link for table */

delimiter //

CREATE PROCEDURE link_table_columns(IN SCHEMA_NAME CHAR(25))

MODIFIES SQL DATA

BEGIN

SET @SCHEMA_NAME = SCHEMA_NAME;

# columns that are not yet in table_edit.table_columns
insert into table_columns
(table_id, column_id) 

SELECT t2._id AS table_id, c2._id AS column_id
from
( # table columns in the information schema
  # table columns are not in dictionary
	select i1.table_schema, i1.table_name, i1.column_name
	from information_schema.`columns` as i1
	
	WHERE i1.table_schema = @SCHEMA_NAME
	and not exists (
		
		# table columns that are already in the dictionary
		select *
		from dictionary.schemas as s
		
		inner join dictionary.schema_tables as st 
		on s._id = st.schema_id
		
		inner join dictionary.tables as t
		on t._id = st.table_id
		
		inner join dictionary.table_columns as tc
		on t._id = tc.table_id
		
		inner join dictionary.columns as c
		on tc.column_id = c._id
		
		where s.name = i1.table_schema
		and t.name = i1.table_name
		and c.name = i1.column_name
	)
	group by i1.table_schema, i1.table_name, i1.column_name) AS a
INNER JOIN dictionary.schemas AS s
ON a.table_schema = s.name

INNER JOIN dictionary.schema_tables AS st2
ON s._id = st2.schema_id

INNER JOIN dictionary.tables AS t2
ON st2.table_id = t2._id
AND a.table_name = t2.name

INNER JOIN dictionary.columns AS c2
ON a.column_name = c2.name;

END;
//

delimiter ;