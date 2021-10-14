SELECT p1.oid, p2.oid  FROM pg_amop AS p1, pg_operator AS p2  WHERE p1.amopopr = p2.oid AND NOT  (p1.amoplefttype = p2.oprleft AND p1.amoprighttype = p2.oprright);
