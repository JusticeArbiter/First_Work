CREATE EVENT TRIGGER end_rls_command ON ddl_command_end  WHEN TAG IN ('CREATE POLICY', 'ALTER POLICY', 'DROP POLICY') EXECUTE PROCEDURE end_command();
