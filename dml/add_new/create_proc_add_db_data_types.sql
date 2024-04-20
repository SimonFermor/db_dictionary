/* Add new data types */

delimiter //

CREATE PROCEDURE add_db_data_types()

MODIFIES SQL DATA

BEGIN

insert into data_types
(name)

select distinct DATA_TYPE
from information_schema.`COLUMNS`
WHERE DATA_TYPE NOT IN (SELECT `NAME` as DATA_TYPE FROM data_types);

END;
//

delimiter ;