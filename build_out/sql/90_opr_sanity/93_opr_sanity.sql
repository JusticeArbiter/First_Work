SELECT p1.amopfamily, p1.amopopr, p2.oid, p2.amname  FROM pg_amop AS p1, pg_am AS p2  WHERE p1.amopmethod = p2.oid AND  p1.amoppurpose = 'o' AND NOT p2.amcanorderbyop;
