SELECT c.oid::pg_catalog.regclass FROM pg_catalog.pg_class c, pg_catalog.pg_inherits i WHERE c.oid=i.inhrelid AND i.inhparent = '24256' ORDER BY c.oid::pg_catalog.regclass::pg_catalog.text;
