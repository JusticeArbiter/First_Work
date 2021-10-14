INSERT INTO document VALUES (33, (SELECT cid from category WHERE cname = 'novel'), 1, 'rls_regress_user1', 'Some novel, replaces sci-fi')  ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle;
