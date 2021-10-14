SELECT ctid, ambuild  FROM pg_catalog.pg_am fk  WHERE ambuild != 0 AND  NOT EXISTS(SELECT 1 FROM pg_catalog.pg_proc pk WHERE pk.oid = fk.ambuild);
