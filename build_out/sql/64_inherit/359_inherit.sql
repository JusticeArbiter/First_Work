SELECT conname, conrelid::pg_catalog.regclass,  pg_catalog.pg_get_constraintdef(c.oid, true) as condef  FROM pg_catalog.pg_constraint c  WHERE c.confrelid = '24298' AND c.contype = 'f' ORDER BY 1;
