CALL add_new_schemas();
CALL add_new_tables('apps');
CALL set_schema_tables('apps');
CALL add_new_columns('apps', 'data_types');