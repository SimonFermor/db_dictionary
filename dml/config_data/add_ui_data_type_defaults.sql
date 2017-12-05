/****** Insert table details into table_edit.ui_data_type_defaults ******/

/***
INSERT INTO table_edit.ui_data_type_defaults
(data_type, maximum_characters, column_width, mapping)
VALUES ('', '', '', '')
***/

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('bit', '65', 'Boolean');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('int', '50', 'Integer');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('money', '50', 'Money');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('numeric', '50', 'Number');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('smalldatetime', '50', 'Datetime');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('smallint','50', 'Integer');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('text','250', 'Textarea');

INSERT INTO table_edit.ui_data_type_defaults
(data_type, column_width, mapping)
VALUES ('tinyint', '20', 'Integer');

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

