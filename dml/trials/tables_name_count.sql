select t1.name, t2.id, count(*) as row_number
from tables as t1
inner join tables as t2
on t1.name = t2.name
and t2.id >= t1.id
and t1.id not in (select table_id from schema_tables)
and t2.id not in (select table_id from schema_tables)
group by t1.name, t2.id
;