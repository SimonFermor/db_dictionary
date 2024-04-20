/* Call all procedures to update tables for new schemas, tables, columns etc. 
   After adding a new schema in_dictionary field needs to be set to import tables etc. */

CALL add_db_data_types();
CALL add_new_schemas();
CALL add_new_tables('dictionary');
CALL set_schema_tables('dictionary');
CALL add_new_columns('dictionary', 'data_types');
