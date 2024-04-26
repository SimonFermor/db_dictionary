/* Add new columns - names are considered to relate to the same data irrespective of source table... */

delimiter //

CREATE PROCEDURE add_new_columns(IN SCHEMA_NAME CHAR(25))

MODIFIES SQL DATA

BEGIN

SET @schema_id = (SELECT _id FROM dictionary.`schemas` WHERE NAME = SCHEMA_NAME);

insert into dictionary.columns 
(schema_id, name, data_type_id)

SELECT @SCHEMA_id AS schema_id, i.COLUMN_NAME, d._id
from information_schema.`COLUMNS` as i

INNER JOIN dictionary.data_types AS d
ON i.DATA_TYPE = d.name

where i.table_schema = SCHEMA_NAME

and not exists
(	select *
	from dictionary.columns AS c
	
	where c.schema_id = @schema_id
	and c.name = i.COLUMN_NAME
);

END;
//

delimiter ;