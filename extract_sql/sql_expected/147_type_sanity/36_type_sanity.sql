SELECT p1.oid, p1.typname, p2.oid, p2.typname  FROM pg_type AS p1, pg_type AS p2  WHERE p1.typarray = p2.oid AND NOT (p1.typdelim = p2.typdelim);
