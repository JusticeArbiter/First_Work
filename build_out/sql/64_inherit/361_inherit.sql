SELECT t.tgname, pg_catalog.pg_get_triggerdef(t.oid, true), t.tgenabled, t.tgisinternal  FROM pg_catalog.pg_trigger t  WHERE t.tgrelid = '24298' AND (NOT t.tgisinternal OR (t.tgisinternal AND t.tgenabled = 'D'))  ORDER BY 1;