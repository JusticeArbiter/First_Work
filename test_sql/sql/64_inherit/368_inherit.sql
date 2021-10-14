SELECT conname,  pg_catalog.pg_get_constraintdef(r.oid, true) as condef  FROM pg_catalog.pg_constraint r  WHERE r.conrelid = '24298' AND r.contype = 'f' ORDER BY 1;
