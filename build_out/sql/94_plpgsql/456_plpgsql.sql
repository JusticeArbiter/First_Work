create function continue_test3() returns void as $$  begin  <<begin_block1>>  begin  loop  continue begin_block1;  end loop;  end;  end;  $$ language plpgsql;
