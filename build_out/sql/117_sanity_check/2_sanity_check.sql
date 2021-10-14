SELECT relname, relhasindex  FROM pg_class c LEFT JOIN pg_namespace n ON n.oid = relnamespace WHERE relkind = 'r' AND (nspname ~ '^pg_temp_') IS NOT TRUE  ORDER BY relname;
