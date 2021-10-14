explain (costs off)  select id from a where id in (  select b.id from b left join c on b.id = c.id  );
