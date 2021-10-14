SELECT ctid, ammarkpos  FROM pg_catalog.pg_am fk  WHERE ammarkpos != 0 AND  NOT EXISTS(SELECT 1 FROM pg_catalog.pg_proc pk WHERE pk.oid = fk.ammarkpos);
