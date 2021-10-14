--TABLE
CREATE TABLE NATION(N_NATIONKEY INTEGER NOT NULL,N_NAME CHAR(25) NOT NULL,N_REGIONKEY INTEGER NOT NULL,N_COMMENT VARCHAR(152));
CREATE TABLE REGION(R_REGIONKEY INTEGER NOT NULL,R_NAME CHAR(25) NOT NULL,R_COMMENT VARCHAR(152));
CREATE TABLE PART(P_PARTKEY INTEGER NOT NULL,P_NAME VARCHAR(55) NOT NULL,P_MFGR CHAR(25) NOT NULL,P_BRAND CHAR(10) NOT NULL,P_TYPE VARCHAR(25) NOT NULL,P_SIZE INTEGER NOT NULL,P_CONTAINER CHAR(10) NOT NULL,P_RETAILPRICE DECIMAL(15,2) NOT NULL,P_COMMENT VARCHAR(23) NOT NULL );
CREATE TABLE SUPPLIER(S_SUPPKEY INTEGER NOT NULL,S_NAME CHAR(25) NOT NULL,S_ADDRESS VARCHAR(40) NOT NULL,S_NATIONKEY INTEGER NOT NULL,S_PHONE CHAR(15) NOT NULL,S_ACCTBAL DECIMAL(15,2) NOT NULL,S_COMMENT VARCHAR(101) NOT NULL);
CREATE TABLE PARTSUPP(PS_PARTKEY INTEGER NOT NULL,PS_SUPPKEY INTEGER NOT NULL,PS_AVAILQTY INTEGER NOT NULL,PS_SUPPLYCOST DECIMAL(15,2) NOT NULL,PS_COMMENT VARCHAR(199) NOT NULL );
CREATE TABLE CUSTOMER(C_CUSTKEY INTEGER NOT NULL,C_NAME VARCHAR(25) NOT NULL,C_ADDRESS VARCHAR(40) NOT NULL,C_NATIONKEY INTEGER NOT NULL,C_PHONE CHAR(15) NOT NULL,C_ACCTBAL DECIMAL(15,2) NOT NULL,C_MKTSEGMENT CHAR(10) NOT NULL,C_COMMENT VARCHAR(117) NOT NULL);
CREATE TABLE ORDERS(O_ORDERKEY INTEGER NOT NULL,O_CUSTKEY INTEGER NOT NULL,O_ORDERSTATUS CHAR(1) NOT NULL,O_TOTALPRICE DECIMAL(15,2) NOT NULL,O_ORDERDATE DATE NOT NULL,O_ORDERPRIORITY CHAR(15) NOT NULL,O_CLERK  CHAR(15) NOT NULL,O_SHIPPRIORITY INTEGER NOT NULL,O_COMMENT VARCHAR(79) NOT NULL);
CREATE TABLE LINEITEM(L_ORDERKEY INTEGER NOT NULL,L_PARTKEY INTEGER NOT NULL,L_SUPPKEY INTEGER NOT NULL,L_LINENUMBER INTEGER NOT NULL,L_QUANTITY DECIMAL(15,2) NOT NULL,L_EXTENDEDPRICE DECIMAL(15,2) NOT NULL,L_DISCOUNT DECIMAL(15,2) NOT NULL,L_TAX  DECIMAL(15,2) NOT NULL,L_RETURNFLAG CHAR(1) NOT NULL,L_LINESTATUS CHAR(1) NOT NULL,L_SHIPDATE DATE NOT NULL,L_COMMITDATE DATE NOT NULL,L_RECEIPTDATE DATE NOT NULL,L_SHIPINSTRUCT CHAR(25) NOT NULL,L_SHIPMODE CHAR(10) NOT NULL,L_COMMENT VARCHAR(44) NOT NULL);

create table orders0 as select * from orders where 1=2;
create table orders1 as select * from orders0 where 1=2;
create table orders2 as select * from orders0 where 1=2;
create table orders3 as select * from orders0 where 1=2;
create table orders4 as select * from orders0 where 1=2;
create table orders5 as select * from orders0 where 1=2;
create table orders6 as select * from orders0 where 1=2;
create table orders7 as select * from orders0 where 1=2;
create table orders8 as select * from orders0 where 1=2;
create table orders9 as select * from orders0 where 1=2;

create table lineitem0 as select * from lineitem where 1=2;
create table lineitem1 as select * from lineitem0 where 1=2;
create table lineitem2 as select * from lineitem0 where 1=2;
create table lineitem3 as select * from lineitem0 where 1=2;
create table lineitem4 as select * from lineitem0 where 1=2;
create table lineitem5 as select * from lineitem0 where 1=2;
create table lineitem6 as select * from lineitem0 where 1=2;
create table lineitem7 as select * from lineitem0 where 1=2;
create table lineitem8 as select * from lineitem0 where 1=2;
create table lineitem9 as select * from lineitem0 where 1=2;

create table delete0(id int);
create table delete1(id int);
create table delete2(id int);
create table delete3(id int);
create table delete4(id int);
create table delete5(id int);
create table delete6(id int);
create table delete7(id int);
create table delete8(id int);
create table delete9(id int);

--DELETE
create or replace function delete0() returns void as $$
declare
delete_cur1 cursor for select id from delete0;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete1() returns void as $$
declare
delete_cur1 cursor for select id from delete1;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete2() returns void as $$
declare
delete_cur1 cursor for select id from delete2;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete3() returns void as $$
declare
delete_cur1 cursor for select id from delete3;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete4() returns void as $$
declare
delete_cur1 cursor for select id from delete4;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete5() returns void as $$
declare
delete_cur1 cursor for select id from delete5;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete6() returns void as $$
declare
delete_cur1 cursor for select id from delete6;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete7() returns void as $$
declare
delete_cur1 cursor for select id from delete7;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete8() returns void as $$
declare
delete_cur1 cursor for select id from delete8;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

create or replace function delete9() returns void as $$
declare
delete_cur1 cursor for select id from delete9;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from lineitem where l_orderkey=v_id;
delete from orders where o_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
end;
$$
language plpgsql;

--INSERT
create or replace function insert0() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders0;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem0;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem0 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;


create or replace function insert1() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders1;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem1;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem1 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;


create or replace function insert2() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders2;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem2;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem2 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;


create or replace function insert3() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders3;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem3;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem3 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

create or replace function insert4() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders4;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem4;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem4 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

create or replace function insert5() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders5;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem5;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem5 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

create or replace function insert6() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders6;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem6;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem6 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

create or replace function insert7() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders7;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem7;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem7 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

create or replace function insert8() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders8;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem8;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem8 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

create or replace function insert9() returns void as $$
declare
insert_cur1 cursor for select o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment from orders9;
insert_cur2 cursor for select l_orderkey,l_partkey,l_suppkey,l_linenumber,l_quantity,l_extendedprice,l_discount,l_tax,l_returnflag,l_linestatus,l_shipdate,l_commitdate,l_receiptdate,l_shipinstruct,l_shipmode,l_comment from lineitem9;
o_orderkey integer;
o_custkey integer;
o_orderstatus character(1);
o_totalprice NUMERIC(28, 6);
o_orderdate DATE;
o_orderpriority CHARACTER(15);
o_clerk CHARACTER(15);
o_shippriority INTEGER;
o_comment CHARACTER VARYING(79);
l_orderkey integer;
l_partkey integer;
l_suppkey integer;
l_linenumber integer;
l_quantity NUMERIC(28, 6);
l_extendedprice NUMERIC(28, 6);
l_discount NUMERIC(28, 6);
l_tax NUMERIC(28, 6);
l_returnflag CHARACTER(1);
l_linestatus CHARACTER(1);
l_shipdate date;
l_commitdate DATE;
l_receiptdate DATE;
l_shipinstruct CHARACTER(25);
l_shipmode CHARACTER(10);
l_comment CHARACTER VARYING(44);
begin
  open insert_cur1;
    fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    raise notice 'Parameter is: %', insert_cur1;
    while found loop
      insert into orders values(o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment);
      insert into lineitem select * from lineitem9 a where a.l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;

