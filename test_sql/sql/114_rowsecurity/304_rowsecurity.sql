CREATE POLICY p1 ON z1 TO rls_regress_group1 USING (a % 2 = 0);
