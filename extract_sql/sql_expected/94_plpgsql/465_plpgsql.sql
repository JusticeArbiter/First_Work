create function end_label2() returns void as $$  begin  for _i in 1 .. 10 loop  exit;  end loop flbl1;  end;  $$ language plpgsql;
