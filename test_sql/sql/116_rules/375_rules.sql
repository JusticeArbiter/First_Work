SELECT viewname, definition FROM pg_views WHERE schemaname <> 'information_schema' ORDER BY viewname;
