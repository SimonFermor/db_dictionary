insert into table_columns
(table_id, column_id) 

# columns that are not yet in table_edit.table_columns
select 
	# e1.table_schema, e1.table_name, e1.column_name, e1.row_number1, 
	# e3.schema_id, 
	e3.table_id,
	e2.id as column_id
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
		
		# columns that are already in table edit
		select *
		from table_edit.schemas as s
			inner join table_edit.schema_tables as st 
			on s.id = st.schema_id
				inner join table_edit.tables as t
				on t.id = st.table_id
					inner join table_edit.table_columns as tc
					on t.id = tc.table_id
						inner join table_edit.columns as c
						on tc.column_id = c.id
		where s.name = i1.table_schema
		and t.name = i1.table_name
		and c.name = i1.column_name
	)
	group by i1.table_schema, i1.table_name, i1.column_name
) as e1

join

( # columns in table edit that have not yet been linked to tables
	select c1.name, c2.id, count(*) as row_number2
	from columns as c1
	
	inner join columns as c2
	on c1.name = c2.name
	and c1.id >= c2.id
	
	where c1.id not in (select column_id from table_columns)
	group by c1.name, c2.id
	collate latin1_general_ci
) as e2

on e1.`row_number1` = e2.`row_number2`
and e1.`column_name` = e2.`name`

join

( # table edit schema and table ids and names
	select s.id as schema_id, s.name as schema_name, 
		t.id as table_id, t.name as table_name
	from table_edit.`schemas` as s
	join table_edit.schema_tables as st
	on s.id = st.schema_id
	join table_edit.`tables` as t
	on st.table_id = t.id
) as e3

on e1.table_schema = e3.schema_name
and e1.table_name = e3.table_name

where e1.table_schema = 'apps'
and e1.table_name = 'apps'

order by column_id, e1.column_name, e2.name
;