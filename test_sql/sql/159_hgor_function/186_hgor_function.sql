select regexp_substr('aBcDefGAbcDefG'::text,'(abc(def(g)))'::text,1,1,'i',1);
