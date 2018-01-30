/****** Insert table details into table_edit.ui_data_type_defaults ******/

/***
INSERT INTO table_edit.ui_data_type_defaults
(data_type, maximum_characters, column_width, mapping)
VALUES ('', '', '', '')
***/

insert into table_edit.ui_data_type_defaults
(data_type, column_width, ui_data_type_id)

select data_type, column_width, u.id as ui_data_type_id
from
(
	select 'bit' as data_type, '65' as column_width, 'Boolean' as ui_data_type_name
	union
	select 'int' as data_type, '50' as colummn_width, 'Integer' as ui_data_type_name
	union
	select 'money' as data_type, '50' as column_width, 'Money' as ui_data_type_name
	union
	select 'numeric' as data_type, '50' as column_width, 'Number' as ui_data_type_name
	union
	select 'smalldatetime' as data_type, '50' as column_width, 'Datetime' as ui_data_type_name
	union
	select 'smallint' as data_type, '50' as column_width, 'Integer' as ui_data_type_name
	union
	select 'text' as data_type, '250' as column_width, 'Textarea' as ui_data_type_name
	union
	select 'tinyint' as data_type, '20' as column_width, 'Integer' as ui_data_type_name
	
) as i

join ui_data_types as u
on binary u.name = i.ui_data_type_name



/*** char ***/
INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('char', '0', '10', '40', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('nchar', '0', '10', '40', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('nvarchar', '0', '10', '40', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('varchar', '0', '10', '40', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('nvarchar', '11', '50', '100', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('varchar', '11', '50', '100', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('varchar', '51', '200', '150', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('varchar', '201', '500', '250', 'String');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, minimum_characters, maximum_characters, column_width, mapping)
VALUES ('varchar', '501', '10000', '250', 'Textarea');

