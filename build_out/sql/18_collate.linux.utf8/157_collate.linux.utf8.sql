do $$  BEGIN  EXECUTE 'CREATE COLLATION test1 (lc_collate = ' ||  quote_literal(current_setting('lc_collate')) ||  ', lc_ctype = ' ||  quote_literal(current_setting('lc_ctype')) || ');';  END  $$;
