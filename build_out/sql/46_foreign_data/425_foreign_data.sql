CREATE TRIGGER trigtest_after_row AFTER INSERT OR UPDATE OR DELETE  ON foreign_schema.foreign_table_1  FOR EACH ROW  EXECUTE PROCEDURE dummy_trigger();
