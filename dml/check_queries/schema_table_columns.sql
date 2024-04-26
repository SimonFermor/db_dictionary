select s._id as schema_id, s.name as schema_name, 
	t._id as table_id, t.name as table_name,
	c._id as column_id, c.name as column_name,
	c.description,
	c.validation_type_id
	
from dictionary.schemas as s

join dictionary.schema_tables as st
on s._id = st.schema_id

join dictionary.tables as t
on t._id = st.table_id

join dictionary.table_columns as tc
on t._id = tc.table_id

join dictionary.`columns` as c
on tc.column_id = c._id

WHERE s.name = 'dictionary'

order BY t.name, c.name

;