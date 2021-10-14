SELECT ctid, amkeytype  FROM pg_catalog.pg_am fk  WHERE amkeytype != 0 AND  NOT EXISTS(SELECT 1 FROM pg_catalog.pg_type pk WHERE pk.oid = fk.amkeytype);
