create or replace function myfunc(int) returns text as $$  begin  set local work_mem = '2MB';  return current_setting('work_mem');  end $$  language plpgsql  set work_mem = '1MB';
