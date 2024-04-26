select s.name as schema_name, s.id as schema_id, 
	t.name as table_name, t.id as table_id, t.description, t.hint, 
	t.allow_delete, t.detail_link_column_id
from dictionary.schemas as s

join table_edit.schema_tables as st
on s._id = st.schema_id

join table_edit.tables as t
on t._id = st.table_id

order by schema_name, table_name;