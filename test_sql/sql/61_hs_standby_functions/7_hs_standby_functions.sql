select locktype, virtualxid, virtualtransaction, mode, granted from pg_locks where virtualxid = '1/1';
