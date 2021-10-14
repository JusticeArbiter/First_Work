SELECT p1.amname, p2.amopfamily, p2.amopstrategy  FROM pg_am AS p1, pg_amop AS p2  WHERE p2.amopmethod = p1.oid AND  p1.amstrategies <> 0 AND p2.amoppurpose <> 's';
