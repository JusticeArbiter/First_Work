select attinhcount, attislocal from pg_attribute  where attrelid = 'oid_child'::regclass and attname = 'oid';
