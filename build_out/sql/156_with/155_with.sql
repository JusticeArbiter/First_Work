CREATE FUNCTION y_trigger() RETURNS trigger AS $$  begin  raise notice 'y_trigger: a = %', new.a;  return new;  end;  $$ LANGUAGE plpgsql;
