SELECT p1.amoplefttype, p1.amoprighttype  FROM pg_amop AS p1  WHERE p1.amopmethod = (SELECT oid FROM pg_am WHERE amname = 'btree') AND  p1.amopstrategy = 3 AND  p1.amoplefttype != p1.amoprighttype AND  NOT EXISTS(SELECT 1 FROM pg_amop p2 WHERE  p2.amopfamily = p1.amopfamily AND  p2.amoplefttype = p1.amoprighttype AND  p2.amoprighttype = p1.amoplefttype AND  p2.amopstrategy = 3);