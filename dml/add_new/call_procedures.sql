/* Call all procedures to update tables for new schemas, tables, columns etc. 
   After adding a new schema in_dictionary field needs to be set to import tables etc. */

CALL add_new_schemas();
CALL add_new_tables('apps');
CALL set_schema_tables('apps');
CALL add_new_columns('apps', 'data_types');