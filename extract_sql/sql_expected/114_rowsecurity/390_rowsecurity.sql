CREATE VIEW rls_sbv WITH (security_barrier) AS  SELECT * FROM y1 WHERE f_leak(b);
