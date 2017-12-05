select s.id as schema_id, s.name as schema_name, 
	t.id as table_id, t.name as table_name,
	c.order_index, c.id as column_id, c.name as column_name,
	c.description, c.width, c.editable, c.fk_table_id, c.ui_data_type_id,
	c.hint, c.encrypted, c.validation_type_id
from table_edit.schemas as s

join table_edit.schema_tables as st
on s.id = st.schema_id

join table_edit.tables as t
on t.id = st.table_id

join table_edit.table_columns as tc
on t.id = tc.table_id

join table_edit.`columns` as c
on tc.column_id = c.id

where t.id = 1

order by s.id, t.id, c.order_index
;