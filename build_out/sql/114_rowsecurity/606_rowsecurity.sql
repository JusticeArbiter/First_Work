SELECT (string_to_array(polqual, ':'))[7] AS inputcollid FROM pg_policy WHERE polrelid = 'coll_t'::regclass;
