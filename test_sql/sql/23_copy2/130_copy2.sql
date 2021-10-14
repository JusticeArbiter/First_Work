SELECT r.conname, pg_catalog.pg_get_constraintdef(r.oid, true)  FROM pg_catalog.pg_constraint r  WHERE r.conrelid = '19739' AND r.contype = 'c'  ORDER BY 1;
