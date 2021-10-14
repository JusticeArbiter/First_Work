CREATE OR REPLACE FUNCTION y_trigger() RETURNS trigger AS $$  begin  raise notice 'y_trigger';  return null;  end;  $$ LANGUAGE plpgsql;
