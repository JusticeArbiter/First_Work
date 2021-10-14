create or replace function case_test(bigint) returns text as $$  declare a int = 10;  b int = 1;  begin  case $1  when 1 then  return 'one';  when 2 then  return 'two';  when 3,4,3+5 then  return 'three, four or eight';  when a then  return 'ten';  when a+b, a+b+1 then  return 'eleven, twelve';  end case;  end;  $$ language plpgsql immutable;