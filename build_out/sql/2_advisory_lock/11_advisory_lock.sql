SELECT locktype, classid, objid, objsubid, mode, granted  FROM pg_locks WHERE locktype = 'advisory'  ORDER BY classid, objid, objsubid;
