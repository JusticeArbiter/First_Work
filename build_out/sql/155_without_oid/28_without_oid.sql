SELECT min(relpages) < max(relpages), min(reltuples) - max(reltuples) FROM pg_class  WHERE relname IN ('wi', 'wo');
