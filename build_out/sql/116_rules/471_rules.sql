SELECT r.rulename, trim(trailing ';' from pg_catalog.pg_get_ruledef(r.oid, true)), ev_enabled  FROM pg_catalog.pg_rewrite r  WHERE r.ev_class = '27317' ORDER BY 1;
