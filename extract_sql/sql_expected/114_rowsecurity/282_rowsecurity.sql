INSERT INTO document VALUES (79, (SELECT cid from category WHERE cname = 'technology'), 1, 'rls_regress_user1', 'technology book, can only insert') ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle RETURNING *;