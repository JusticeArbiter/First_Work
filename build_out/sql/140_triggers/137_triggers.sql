create function trigtest() returns trigger as $$  begin  raise notice '% % % %', TG_RELNAME, TG_OP, TG_WHEN, TG_LEVEL;  return new;  end;$$ language plpgsql;
