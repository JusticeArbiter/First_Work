CREATE AGGREGATE array_cat_accum (anyarray)  (  sfunc = array_cat,  stype = anyarray,  initcond = '{}'  );
