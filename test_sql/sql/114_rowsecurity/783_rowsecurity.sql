CREATE POLICY dep_p1 ON dep1 TO rls_regress_user1 USING (c1 > (select max(dep2.c1) from dep2));
