CREATE TABLE selinto_schema.tmp3 (a,b,c)  AS SELECT oid,relname,relacl FROM pg_class  WHERE relname like '%c%';
