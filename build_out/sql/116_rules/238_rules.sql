create view rtest_vview5 as select a, b, rtest_viewfunc1(a) as refcount  from rtest_view1;
