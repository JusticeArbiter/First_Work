create function check_con_function(check_con_tbl) returns bool as $$  begin  raise notice 'input = %', row_to_json($1);  return $1.f1 > 0;  end $$ language plpgsql immutable;
