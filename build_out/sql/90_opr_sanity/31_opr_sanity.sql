SELECT p1.oid::regprocedure  FROM pg_proc p1 JOIN pg_namespace pn  ON pronamespace = pn.oid  WHERE nspname = 'pg_catalog' AND proleakproof  ORDER BY 1;
