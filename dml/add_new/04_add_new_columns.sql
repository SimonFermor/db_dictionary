SET @SCHEMA_NAME = 'dictionary';
SET @TABLE_NAME = 'data_types';

insert into dictionary.fields 
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
		
	inner join dictionary.table_fields tc
	on t._id = tc.table_id
		
	inner join dictionary.fields as c
	on tc.field_id = c._id
	
	where s.name = i.TABLE_SCHEMA
	and t.name = i.TABLE_NAME
	and c.name = i.COLUMN_NAME
)