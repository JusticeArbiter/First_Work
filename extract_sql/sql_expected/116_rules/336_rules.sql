DELETE FROM shoelace WHERE EXISTS  (SELECT * FROM shoelace_candelete  WHERE sl_name = shoelace.sl_name);
