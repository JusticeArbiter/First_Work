SELECT sum(unique1) over (rows between unbounded preceding and 1 following),  unique1, four  FROM tenk1 WHERE unique1 < 10;
