CREATE FUNCTION truncate_in_subxact() RETURNS VOID AS  $$  BEGIN  TRUNCATE vistest;  EXCEPTION  WHEN OTHERS THEN  INSERT INTO vistest VALUES ('subxact failure');  END;  $$ language plpgsql;
