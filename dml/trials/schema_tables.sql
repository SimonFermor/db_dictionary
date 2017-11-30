select table_id, count(schema_id)
from table_edit.schema_tables
group by table_id;