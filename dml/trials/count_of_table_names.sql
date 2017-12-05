select i1.table_name , i2.table_schema, count(*) as table_counter
from information_schema.`tables` as i1
inner join information_schema.`TABLES` as i2 
on i1.table_name = i2.table_name
and i1.create_time >= i2.create_time
where i1.TABLE_TYPE = 'BASE TABLE'
and i2.TABLE_TYPE = 'BASE TABLE'
group by i1.table_name, i2.table_schema
order by i1.table_name, table_counter