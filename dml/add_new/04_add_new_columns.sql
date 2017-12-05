insert into table_edit.columns 
(name)

select i.column_name
from information_schema.`COLUMNS` as i

where i.table_schema not in ('mysql', 'performance_schema','information_schema')

and not exists
(select *
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
and c.name = i.COLUMN_NAME)