SELECT oid, proname  FROM pg_proc as p  WHERE p.proisagg AND  NOT EXISTS (SELECT 1 FROM pg_aggregate a WHERE a.aggfnoid = p.oid);
