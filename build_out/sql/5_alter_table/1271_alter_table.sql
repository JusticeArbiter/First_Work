SELECT m.* FROM filenode_mapping m LEFT JOIN pg_class c ON c.oid = m.oid  WHERE c.oid IS NOT NULL OR m.mapped_oid IS NOT NULL;
