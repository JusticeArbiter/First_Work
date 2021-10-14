CREATE POLICY p2 ON t1 TO rls_regress_user2 USING ((a % 4) = 0);
