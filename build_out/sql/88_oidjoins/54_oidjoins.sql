SELECT ctid, contypid  FROM pg_catalog.pg_constraint fk  WHERE contypid != 0 AND  NOT EXISTS(SELECT 1 FROM pg_catalog.pg_type pk WHERE pk.oid = fk.contypid);
