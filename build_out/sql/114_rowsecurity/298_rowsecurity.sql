INSERT INTO document VALUES (1, (SELECT cid from category WHERE cname = 'novel'), 1, 'rls_regress_user1', 'my first novel')  ON CONFLICT (did) DO UPDATE SET dauthor = 'rls_regress_user2';
