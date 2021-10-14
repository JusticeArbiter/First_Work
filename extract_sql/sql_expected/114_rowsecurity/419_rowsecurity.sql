CREATE POLICY p1 ON t1 TO rls_regress_user1 USING ((a % 2) = 0);
