SELECT ctid, amgettuple  FROM pg_catalog.pg_am fk  WHERE amgettuple != 0 AND  NOT EXISTS(SELECT 1 FROM pg_catalog.pg_proc pk WHERE pk.oid = fk.amgettuple);
