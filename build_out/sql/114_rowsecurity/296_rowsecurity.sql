INSERT INTO document VALUES (80, (SELECT cid from category WHERE cname = 'novel'), 1, 'rls_regress_user2', 'my first novel')  ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle, cid = 33;
