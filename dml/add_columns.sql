insert into table_edit.columns 
(name)

select c1.column_name
from tables t
left join information_schema.columns as c1
on t.name = c1.table_name
where not exists
	(select * 
	from columns as c2
	inner join table_columns as tc
	on c2.id = tc.column_id
	where binary c2.name = binary c1.column_name
	and tc.table_id = t.id
	)