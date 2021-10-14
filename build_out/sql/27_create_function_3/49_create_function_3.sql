SELECT proname, proisstrict FROM pg_proc  WHERE oid in ('functext_F_1'::regproc,  'functext_F_2'::regproc,  'functext_F_3'::regproc,  'functext_F_4'::regproc) ORDER BY proname;
