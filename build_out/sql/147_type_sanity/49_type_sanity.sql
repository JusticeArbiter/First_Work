SELECT p1.rngtypid, p1.rngsubtype, p1.rngcollation, t.typcollation  FROM pg_range p1 JOIN pg_type t ON t.oid = p1.rngsubtype  WHERE (rngcollation = 0) != (typcollation = 0);
