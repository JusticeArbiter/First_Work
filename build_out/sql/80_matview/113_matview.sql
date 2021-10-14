CREATE VIEW v_test2 AS SELECT moo, 2*moo FROM v_test1 UNION ALL SELECT moo, 3*moo FROM v_test1;
