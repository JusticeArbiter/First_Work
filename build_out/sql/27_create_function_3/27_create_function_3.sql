SELECT proname, proleakproof FROM pg_proc  WHERE oid in ('functext_E_1'::regproc,  'functext_E_2'::regproc) ORDER BY proname;
