WITH rcte AS ( SELECT sum(id) AS totalid FROM parent )  UPDATE parent SET id = id + totalid FROM rcte;
