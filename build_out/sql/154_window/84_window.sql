CREATE AGGREGATE logging_agg_nonstrict (anyelement)  (  stype = text,  sfunc = logging_sfunc_nonstrict,  mstype = text,  msfunc = logging_msfunc_nonstrict,  minvfunc = logging_minvfunc_nonstrict  );
