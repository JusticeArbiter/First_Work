CREATE POLICY p2 ON z1 TO rls_regress_group2 USING (a % 2 = 1);
