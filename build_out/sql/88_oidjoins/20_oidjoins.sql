SELECT ctid, ambuildempty  FROM pg_catalog.pg_am fk  WHERE ambuildempty != 0 AND  NOT EXISTS(SELECT 1 FROM pg_catalog.pg_proc pk WHERE pk.oid = fk.ambuildempty);
