create function continue_test2() returns void as $$  begin  begin  continue;  end;  return;  end;  $$ language plpgsql;
