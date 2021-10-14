BEGIN;

CREATE TABLE PART (
  P_PARTKEY               SERIAL8,
  P_NAME                  VARCHAR(55),
  P_MFGR                  CHAR(25),
  P_BRAND                 CHAR(10),
  P_TYPE                  VARCHAR(25),
  P_SIZE                  INTEGER,
  P_CONTAINER             CHAR(10),
  P_RETAILPRICE   DECIMAL,
  P_COMMENT               VARCHAR(23)
) DISTRIBUTED BY (p_partkey);

COPY part FROM '/home/hgadmin1/tpch-tools/dbgen/part.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

CREATE TABLE REGION (
  R_REGIONKEY     SERIAL8,
  R_NAME          CHAR(25),
  R_COMMENT       VARCHAR(152)
)  DISTRIBUTED BY (r_regionkey);

COPY region FROM '/home/hgadmin1/tpch-tools/dbgen/region.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

CREATE TABLE NATION (
  N_NATIONKEY             SERIAL8,
  N_NAME                  CHAR(25),
  N_REGIONKEY             BIGINT NOT NULL,  -- references R_REGIONKEY
  N_COMMENT               VARCHAR(152)
) DISTRIBUTED BY (n_nationkey);

COPY nation FROM '/home/hgadmin1/tpch-tools/dbgen/nation.csv' WITH csv DELIMITER '|';

CREATE INDEX IDX_NATION_REGIONKEY ON NATION (N_REGIONKEY);

COMMIT;

BEGIN;

CREATE TABLE SUPPLIER (
  S_SUPPKEY               SERIAL8,
  S_NAME                  CHAR(25),
  S_ADDRESS               VARCHAR(40),
  S_NATIONKEY             BIGINT NOT NULL, -- references N_NATIONKEY
  S_PHONE                 CHAR(15),
  S_ACCTBAL               DECIMAL,
  S_COMMENT               VARCHAR(101)
) ;

COPY supplier FROM '/home/hgadmin1/tpch-tools/dbgen/supplier.csv' WITH csv DELIMITER '|';

CREATE INDEX IDX_SUPPLIER_NATION_KEY ON SUPPLIER (S_NATIONKEY);

COMMIT;

BEGIN;

CREATE TABLE CUSTOMER (
  C_CUSTKEY               SERIAL8,
  C_NAME                  VARCHAR(25),
  C_ADDRESS               VARCHAR(40),
  C_NATIONKEY             BIGINT NOT NULL, -- references N_NATIONKEY
  C_PHONE                 CHAR(15),
  C_ACCTBAL               DECIMAL,
  C_MKTSEGMENT    CHAR(10),
  C_COMMENT               VARCHAR(117)
) ;

COPY customer FROM '/home/hgadmin1/tpch-tools/dbgen/customer.csv' WITH csv DELIMITER '|';

CREATE INDEX IDX_CUSTOMER_NATIONKEY ON CUSTOMER (C_NATIONKEY);

COMMIT;

BEGIN;

CREATE TABLE PARTSUPP (
  PS_PARTKEY              BIGINT NOT NULL, -- references P_PARTKEY
  PS_SUPPKEY              BIGINT NOT NULL, -- references S_SUPPKEY
  PS_AVAILQTY             INTEGER,
  PS_SUPPLYCOST   DECIMAL,
  PS_COMMENT              VARCHAR(199)
) DISTRIBUTED BY (ps_partkey,ps_suppkey);

COPY partsupp FROM '/home/hgadmin1/tpch-tools/dbgen/partsupp.csv' WITH csv DELIMITER '|';

CREATE INDEX IDX_PARTSUPP_PARTKEY ON PARTSUPP (PS_PARTKEY);
CREATE INDEX IDX_PARTSUPP_SUPPKEY ON PARTSUPP (PS_SUPPKEY);

COMMIT;

BEGIN;

CREATE TABLE ORDERS (
  O_ORDERKEY              SERIAL8,
  O_CUSTKEY               BIGINT NOT NULL, -- references C_CUSTKEY
  O_ORDERSTATUS   CHAR(1),
  O_TOTALPRICE    DECIMAL,
  O_ORDERDATE             DATE,
  O_ORDERPRIORITY CHAR(15),
  O_CLERK                 CHAR(15),
  O_SHIPPRIORITY  INTEGER,
  O_COMMENT               VARCHAR(79)
) DISTRIBUTED BY (o_orderkey);

COPY orders FROM '/home/hgadmin1/tpch-tools/dbgen/orders.csv' WITH csv DELIMITER '|';

CREATE INDEX IDX_ORDERS_CUSTKEY ON ORDERS (O_CUSTKEY);

CREATE INDEX IDX_ORDERS_ORDERKEY1 ON ORDERS using btree (O_ORDERKEY);

CREATE INDEX IDX_ORDERS_ORDERDATE ON ORDERS (O_ORDERDATE);

COMMIT;

BEGIN;

CREATE TABLE LINEITEM (
  L_ORDERKEY              BIGINT NOT NULL, -- references O_ORDERKEY
  L_PARTKEY               BIGINT NOT NULL, -- references P_PARTKEY (compound fk to PARTSUPP)
  L_SUPPKEY               BIGINT NOT NULL, -- references S_SUPPKEY (compound fk to PARTSUPP)
  L_LINENUMBER    INTEGER,
  L_QUANTITY              DECIMAL,
  L_EXTENDEDPRICE DECIMAL,
  L_DISCOUNT              DECIMAL,
  L_TAX                   DECIMAL,
  L_RETURNFLAG    CHAR(1),
  L_LINESTATUS    CHAR(1),
  L_SHIPDATE              DATE,
  L_COMMITDATE    DATE,
  L_RECEIPTDATE   DATE,
  L_SHIPINSTRUCT  CHAR(25),
  L_SHIPMODE              CHAR(10),
  L_COMMENT               VARCHAR(44)
) DISTRIBUTED BY (l_orderkey, l_linenumber);

COPY lineitem FROM '/home/hgadmin1/tpch-tools/dbgen/lineitem.csv' WITH csv DELIMITER '|';

CREATE INDEX IDX_LINEITEM_ORDERKEY ON LINEITEM using btree (L_ORDERKEY);
CREATE INDEX IDX_LINEITEM_PART_SUPP ON LINEITEM (L_PARTKEY,L_SUPPKEY);
CREATE INDEX IDX_LINEITEM_SHIPDATE ON LINEITEM (L_SHIPDATE, L_DISCOUNT, L_QUANTITY);

COMMIT;


create table orders1 as select * from orders where 1=2;
create table orders2 as select * from orders1 where 1=2;
create table orders3 as select * from orders1 where 1=2;
create table orders4 as select * from orders1 where 1=2;
create table orders5 as select * from orders1 where 1=2;

create table lineitem1 as select * from lineitem where 1=2;
create table lineitem2 as select * from lineitem1 where 1=2;
create table lineitem3 as select * from lineitem1 where 1=2;
create table lineitem4 as select * from lineitem1 where 1=2;
create table lineitem5 as select * from lineitem1 where 1=2;

create table delete1(id int);
create table delete2(id int);
create table delete3(id int);
create table delete4(id int);
create table delete5(id int);

create or replace function delete1() returns void as $$
declare
delete_cur1 cursor for select id from delete1;
v_id integer;
begin
open delete_cur1;
fetch delete_cur1 into v_id;
while found loop
delete from orders where o_orderkey=v_id;
delete from lineitem where l_orderkey=v_id;
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
delete from orders where o_orderkey=v_id;
delete from lineitem where l_orderkey=v_id;
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
delete from orders where o_orderkey=v_id;
delete from lineitem where l_orderkey=v_id;
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
delete from orders where o_orderkey=v_id;
delete from lineitem where l_orderkey=v_id;
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
delete from orders where o_orderkey=v_id;
delete from lineitem where l_orderkey=v_id;
fetch delete_cur1 into v_id;
end loop;
close delete_cur1;
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
      insert into lineitem select * from lineitem1 where l_orderkey=o_orderkey;
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
      insert into lineitem select * from lineitem2 where l_orderkey=o_orderkey;
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
      insert into lineitem select * from lineitem3 where l_orderkey=o_orderkey;
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
      insert into lineitem select * from lineitem4 where l_orderkey=o_orderkey;
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
      insert into lineitem select * from lineitem5 where l_orderkey=o_orderkey;
      fetch insert_cur1 into o_orderkey,o_custkey,o_orderstatus,o_totalprice,o_orderdate,o_orderpriority,o_clerk,o_shippriority,o_comment;
    end loop;
  close insert_cur1;
end;
$$
language plpgsql;
