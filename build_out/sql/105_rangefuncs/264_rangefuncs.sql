CREATE OR REPLACE FUNCTION foo()  RETURNS TABLE(a varchar(5))  AS $$ SELECT 'hello'::varchar(5) $$ LANGUAGE sql STABLE;
