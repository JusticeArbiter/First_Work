ALTER TABLE FKTABLE ADD CONSTRAINT fknd2 FOREIGN KEY(ftest1) REFERENCES pktable  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
