CREATE FUNCTION boo(int) RETURNS int IMMUTABLE STRICT LANGUAGE plpgsql AS $$ BEGIN RAISE NOTICE 'boo: %', $1; RETURN $1; END; $$;