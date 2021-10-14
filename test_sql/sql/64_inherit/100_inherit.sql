/* Test multiple inheritance of column defaults */  CREATE TABLE firstparent (tomorrow date default now()::date + 1);
