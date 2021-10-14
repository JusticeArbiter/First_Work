select reltoastrelid, relkind, relfrozenxid  from pg_class where oid = 'fooview'::regclass;
