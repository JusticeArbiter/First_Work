explain (costs off) insert into insertconflicttest values(0, 'Crowberry') on conflict (lower(fruit), key, lower(fruit), key) do nothing;
