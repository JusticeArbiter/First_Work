SELECT * FROM dropped_objects WHERE schema IS NULL OR schema <> 'pg_toast';
