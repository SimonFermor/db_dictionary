insert into table_edit.columns 
(name, data_type, ui_data_type_id)

select i.column_name, i.DATA_TYPE, d.ui_data_type_id
from information_schema.`COLUMNS` as i

join table_edit.ui_data_type_defaults as d
on i.DATA_TYPE = d.data_type
and ((i.CHARACTER_MAXIMUM_LENGTH <= d.maximum_characters
	and i.CHARACTER_MAXIMUM_LENGTH >= d.minimum_characters)
	or d.minimum_characters is null)
	
where i.table_schema not in ('mysql', 'performance_schema','information_schema')

and i.table_schema = 'apps'
and i.TABLE_NAME = 'apps'

and not exists
(	select *
	from table_edit.schemas as s
		inner join table_edit.schema_tables as st
		on s.id = st.schema_id
			inner join table_edit.tables as t
			on st.table_id = t.id
				inner join table_edit.table_columns tc
				on t.id = tc.table_id
					inner join table_edit.columns as c
					on tc.column_id = c.id
	where s.name = i.TABLE_SCHEMA
	and t.name = i.TABLE_NAME
	and c.name = i.COLUMN_NAME
)