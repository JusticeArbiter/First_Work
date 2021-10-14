CREATE POLICY p2 ON category  USING (CASE WHEN current_user = 'rls_regress_user1' THEN cid IN (11, 33)  WHEN current_user = 'rls_regress_user2' THEN cid IN (22, 44)  ELSE false END);
