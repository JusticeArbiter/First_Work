SELECT p1.oid, p1.relname  FROM pg_class as p1  WHERE p1.relkind NOT IN ('r', 'i', 's', 'S', 'c', 't', 'v', 'f');
