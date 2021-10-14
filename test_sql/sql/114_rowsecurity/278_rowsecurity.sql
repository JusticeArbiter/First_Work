INSERT INTO document VALUES (2, (SELECT cid from category WHERE cname = 'novel'), 1, 'rls_regress_user1', 'my first novel')  ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle RETURNING *;
