create function non_strict(text) returns text as  'select coalesce($1, ''got passed a null'');'  language sql called on null input;
