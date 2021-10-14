SELECT refclassid::regclass, deptype  FROM pg_shdepend  WHERE classid = 'pg_policy'::regclass  AND refobjid IN ('alice'::regrole, 'bob'::regrole);
