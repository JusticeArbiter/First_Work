WITH wcte AS ( INSERT INTO child1 VALUES ( 42, 'new' ) RETURNING id AS newid )  UPDATE parent SET id = id + newid FROM wcte;
