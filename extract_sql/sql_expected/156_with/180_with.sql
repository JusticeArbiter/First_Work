WITH rcte AS ( SELECT max(id) AS maxid FROM parent )  DELETE FROM parent USING rcte WHERE id = maxid;
