create function test_strict(text) returns text as  'select coalesce($1, ''got passed a null'');'  language sql returns null on null input;
