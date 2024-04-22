/* Add new column link for table */

delimiter //

CREATE PROCEDURE link_table_columns(IN SCHEMA_NAME CHAR(25), IN TABLE_NAME CHAR(25))

MODIFIES SQL DATA

BEGIN

SET @SCHEMA_NAME = SCHEMA_NAME;
SET @TABLE_NAME = TABLE_NAME;

insert into table_columns
(table_id, column_id) 

# columns that are not yet in table_edit.table_columns
select 
	# e1.table_schema, e1.table_name, e1.column_name, e1.row_number1, 
	# e3.schema_id, 
	e3.table_id,
	e2._id as column_id
from 

( # columns in the information schema, with row numbers for column name groupings
	select i1.table_schema, i1.table_name, i1.column_name, 
		count(*) as row_number1
	from information_schema.`columns` as i1
	
	inner join information_schema.`columns` as i2 
	on i1.column_name = i2.column_name
	and i1.table_schema = i2.table_schema
	and i1.table_name >= i2.table_name
	
	where not exists (
		
		# columns that are already in the dictionary
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
	group by i1.table_schema, i1.table_name, i1.column_name
) as e1

join

( # columns in table edit that have not yet been linked to tables
	select c1.name, c2._id, count(*) as row_number2
	from dictionary.columns as c1
	
	inner join dictionary.columns as c2
	on c1.name = c2.name
	and c1._id >= c2._id
	
	where c1._id not in (select column_id from table_columns)
	group by c1.name, c2._id
	collate latin1_general_ci
) as e2

on e1.`row_number1` = e2.`row_number2`
and e1.`column_name` = e2.`name`

join

( # table edit schema and table ids and names
	select s._id as schema_id, s.name as schema_name, 
		t._id as table_id, t.name as table_name
	from dictionary.`schemas` as s
	
	join dictionary.schema_tables as st
	on s._id = st.schema_id
	
	join dictionary.`tables` as t
	on st.table_id = t._id
) as e3

on e1.table_schema = e3.schema_name
and e1.table_name = e3.table_name

where e1.table_schema = @SCHEMA_NAME
and e1.table_name = @TABLE_NAME

order by column_id, e1.column_name, e2.name;

END;
//

delimiter ;