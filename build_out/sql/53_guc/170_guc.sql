create or replace function myfunc(int) returns text as $$  begin  set work_mem = '2MB';  perform 1/$1;  return current_setting('work_mem');  end $$  language plpgsql  set work_mem = '1MB';
