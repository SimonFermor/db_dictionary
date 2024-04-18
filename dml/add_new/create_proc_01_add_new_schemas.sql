/* Add new schemas */

delimiter //

CREATE PROCEDURE add_new_schemas()

MODIFIES SQL DATA

BEGIN

insert into dictionary.schemas 
(name)

select schema_name
from information_schema.schemata
where schema_name not in 
(
	select name from dictionary.schemas
);

END;
//

delimiter ;