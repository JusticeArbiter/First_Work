CREATE OR REPLACE FUNCTION test_evtrig_no_rewrite() RETURNS event_trigger  LANGUAGE plpgsql AS $$  BEGIN  RAISE EXCEPTION 'I''m sorry Sir, No Rewrite Allowed.';  END;  $$;
