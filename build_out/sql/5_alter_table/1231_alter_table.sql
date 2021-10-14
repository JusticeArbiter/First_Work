SELECT c.oid,  n.nspname,  c.relname  FROM pg_catalog.pg_class c  LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace  WHERE c.relname ~ '^(tt8)$'  AND n.nspname ~ '^(alter2)$'  ORDER BY 2, 3;