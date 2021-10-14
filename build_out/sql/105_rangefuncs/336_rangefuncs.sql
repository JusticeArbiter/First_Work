create or replace function foobar() returns setof text as  $$ select 'foo'::varchar union all select 'bar'::varchar ; $$  language sql stable;
