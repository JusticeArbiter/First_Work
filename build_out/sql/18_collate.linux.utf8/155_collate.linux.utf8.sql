do $$  BEGIN  EXECUTE 'CREATE COLLATION test0 (locale = ' ||  quote_literal(current_setting('lc_collate')) || ');';  END  $$;
