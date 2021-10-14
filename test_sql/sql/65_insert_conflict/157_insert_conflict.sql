insert into testoids values(1, '3') on conflict (key) do update set data = excluded.data RETURNING *;
