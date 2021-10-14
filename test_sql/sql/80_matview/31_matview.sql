SELECT r.rulename, trim(trailing ';' from pg_catalog.pg_get_ruledef(r.oid, true))  FROM pg_catalog.pg_rewrite r  WHERE r.ev_class = '24834' AND r.rulename != '_RETURN' ORDER BY 1;
