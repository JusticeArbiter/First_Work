create function scope_test() returns int as $$  declare x int := 42;  begin  declare y int := x + 1;  x int := x + 2;  begin  return x * 100 + y;  end;  end;  $$ language plpgsql;
