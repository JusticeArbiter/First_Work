CREATE VIEW mysecview5 WITH (security_barrier=100)  AS SELECT * FROM tbl1 WHERE a > 100;
