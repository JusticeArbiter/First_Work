SELECT p1.amopfamily, p1.amopstrategy  FROM pg_amop AS p1  WHERE p1.amopsortfamily <> 0 AND NOT EXISTS  (SELECT 1 from pg_opfamily op WHERE op.oid = p1.amopsortfamily  AND op.opfmethod = (SELECT oid FROM pg_am WHERE amname = 'btree'));