create event trigger regress_event_trigger2 on ddl_command_start  when food in ('sandwhich')  execute procedure test_event_trigger();
