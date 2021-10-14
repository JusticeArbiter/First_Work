1.启动并行加载服务
切换到4个计算节点，启动gpfdist服务
[gpadmin@indata-172-30-11-102 ~]$ source hgdw/greenplum_path.sh
[gpadmin@indata-172-30-11-102 ~]$ gpfdist -d /indata/disk_9/hgdata/ -p 8081 -l /tmp/gpfdist.log &

2.创建测试数据库
postgres=# drop database tpch;
DROP DATABASE
postgres=# create database tpch;
CREATE DATABASE

3.创建测试表(使用/Users/chris/tpch/2.17.2/dbgen/dss/ps_tpch_dbinit.sql中的建表语句性能看起来会高)
CREATE TABLE PART (
    P_PARTKEY        SERIAL8,
    P_NAME            VARCHAR(55),
    P_MFGR            CHAR(25),
    P_BRAND            CHAR(10),
    P_TYPE            VARCHAR(25),
    P_SIZE            INTEGER,
    P_CONTAINER        CHAR(10),
    P_RETAILPRICE    DECIMAL,
    P_COMMENT        VARCHAR(23)
) with (APPENDONLY=true, ORIENTATION=column, BLOCKSIZE=2097152,CHECKSUM=true,COMPRESSTYPE=zlib, OIDS=false) DISTRIBUTED BY (P_PARTKEY);

CREATE TABLE SUPPLIER (
    S_SUPPKEY        SERIAL,
    S_NAME            CHAR(25),
    S_ADDRESS        VARCHAR(40),
    S_NATIONKEY        INTEGER NOT NULL, -- references N_NATIONKEY
    S_PHONE            CHAR(15),
    S_ACCTBAL        DECIMAL,
    S_COMMENT        VARCHAR(101)
)with (APPENDONLY=true, ORIENTATION=column, BLOCKSIZE=2097152,CHECKSUM=true,COMPRESSTYPE=zlib, OIDS=false) DISTRIBUTED BY (S_SUPPKEY);

CREATE TABLE PARTSUPP (
    PS_PARTKEY        bigint NOT NULL, -- references P_PARTKEY
    PS_SUPPKEY        integer NOT NULL, -- references S_SUPPKEY
    PS_AVAILQTY        integer,
    PS_SUPPLYCOST    DECIMAL,
    PS_COMMENT        VARCHAR(199)
)with (APPENDONLY=true, ORIENTATION=column, BLOCKSIZE=2097152,CHECKSUM=true,COMPRESSTYPE=zlib, OIDS=false) DISTRIBUTED BY (PS_PARTKEY,PS_SUPPKEY);

CREATE TABLE CUSTOMER (
    C_CUSTKEY        SERIAL,
    C_NAME            VARCHAR(25),
    C_ADDRESS        VARCHAR(40),
    C_NATIONKEY        INTEGER NOT NULL, -- references N_NATIONKEY
    C_PHONE            CHAR(15),
    C_ACCTBAL        DECIMAL,
    C_MKTSEGMENT    CHAR(10),
    C_COMMENT        VARCHAR(117)
)with (APPENDONLY=true, ORIENTATION=column, BLOCKSIZE=2097152,CHECKSUM=true,COMPRESSTYPE=zlib, OIDS=false) DISTRIBUTED BY (C_CUSTKEY);

CREATE TABLE ORDERS (
    O_ORDERKEY        bigSERIAL,
    O_CUSTKEY        INTEGER NOT NULL, -- references C_CUSTKEY
    O_ORDERSTATUS    CHAR(1),
    O_TOTALPRICE    DECIMAL,
    O_ORDERDATE        DATE,
    O_ORDERPRIORITY    CHAR(15),
    O_CLERK            CHAR(15),
    O_SHIPPRIORITY    INTEGER,
    O_COMMENT        VARCHAR(79)
)with (APPENDONLY=true, ORIENTATION=column, BLOCKSIZE=2097152,CHECKSUM=true,COMPRESSTYPE=zlib, OIDS=false) DISTRIBUTED BY (O_ORDERKEY);

CREATE TABLE LINEITEM (
    L_ORDERKEY        bigint NOT NULL, -- references O_ORDERKEY
    L_PARTKEY        INTEGER NOT NULL, -- references P_PARTKEY (compound fk to PARTSUPP)
    L_SUPPKEY        INTEGER NOT NULL, -- references S_SUPPKEY (compound fk to PARTSUPP)
    L_LINENUMBER    INTEGER,
    L_QUANTITY        DECIMAL,
    L_EXTENDEDPRICE    DECIMAL,
    L_DISCOUNT        DECIMAL,
    L_TAX            DECIMAL,
    L_RETURNFLAG    CHAR(1),
    L_LINESTATUS    CHAR(1),
    L_SHIPDATE        DATE,
    L_COMMITDATE    DATE,
    L_RECEIPTDATE    DATE,
    L_SHIPINSTRUCT    CHAR(25),
    L_SHIPMODE        CHAR(10),
    L_COMMENT        VARCHAR(44)
)with (APPENDONLY=true, ORIENTATION=column, BLOCKSIZE=2097152,CHECKSUM=true,COMPRESSTYPE=zlib, OIDS=false) DISTRIBUTED BY (L_ORDERKEY);

CREATE TABLE NATION (
    N_NATIONKEY        SERIAL,
    N_NAME            CHAR(25),
    N_REGIONKEY        INTEGER NOT NULL,  -- references R_REGIONKEY
    N_COMMENT        VARCHAR(152)
);

CREATE TABLE REGION (
    R_REGIONKEY    SERIAL,
    R_NAME        CHAR(25),
    R_COMMENT    VARCHAR(152)
);

4.创建外部表加载数据
CREATE EXTERNAL TABLE SUPPLIER_EXT (    S_SUPPKEY        integer,    S_NAME            CHAR(25),    S_ADDRESS        VARCHAR(40),    S_NATIONKEY        INTEGER ,    S_PHONE            CHAR(15),    S_ACCTBAL        DECIMAL,    S_COMMENT        VARCHAR(101)
)LOCATION ('gpfdist://172.30.11.101:8082/supplier_csv_*') FORMAT 'CSV' (DELIMITER '|' NULL '');

CREATE EXTERNAL TABLE PART_EXT (
    P_PARTKEY        INTEGER,
    P_NAME            VARCHAR(55),
    P_MFGR            CHAR(25),
    P_BRAND            CHAR(10),
    P_TYPE            VARCHAR(25),
    P_SIZE            INTEGER,
    P_CONTAINER        CHAR(10),
    P_RETAILPRICE    DECIMAL,
    P_COMMENT        VARCHAR(23)
) LOCATION('gpfdist://172.30.11.101:8082/part_csv_*')  FORMAT 'CSV' (DELIMITER '|' NULL '');






CREATE EXTERNAL TABLE PARTSUPP_EXT (
    PS_PARTKEY        bigint,
    PS_SUPPKEY        INTEGER,
    PS_AVAILQTY        INTEGER,
    PS_SUPPLYCOST    DECIMAL,
    PS_COMMENT        VARCHAR(199)
)LOCATION ('gpfdist://172.30.11.101:8082/partsupp_csv_*') FORMAT 'CSV' (DELIMITER '|' NULL '');

CREATE EXTERNAL TABLE CUSTOMER_EXT (
    C_CUSTKEY        INTEGER,
    C_NAME            VARCHAR(25),
    C_ADDRESS        VARCHAR(40),
    C_NATIONKEY        INTEGER,
    C_PHONE            CHAR(15),
    C_ACCTBAL        DECIMAL,
    C_MKTSEGMENT    CHAR(10),
    C_COMMENT        VARCHAR(117)
)LOCATION ('gpfdist://172.30.11.101:8082/customer_csv_*') FORMAT 'CSV' (DELIMITER '|' NULL '');

CREATE EXTERNAL TABLE ORDERS_EXT (
    O_ORDERKEY        bigint,
    O_CUSTKEY        INTEGER,
    O_ORDERSTATUS    CHAR(1),
    O_TOTALPRICE    DECIMAL,
    O_ORDERDATE        DATE,
    O_ORDERPRIORITY    CHAR(15),
    O_CLERK            CHAR(15),
    O_SHIPPRIORITY    INTEGER,
    O_COMMENT        VARCHAR(79)
)LOCATION ('gpfdist://172.30.11.101:8082/orders_csv_*') FORMAT 'CSV' (DELIMITER '|' NULL '');

CREATE EXTERNAL TABLE LINEITEM_EXT (
    L_ORDERKEY        bigint,
    L_PARTKEY        INTEGER,
    L_SUPPKEY        bigint,
    L_LINENUMBER    INTEGER,
    L_QUANTITY        DECIMAL,
    L_EXTENDEDPRICE    DECIMAL,
    L_DISCOUNT        DECIMAL,
    L_TAX            DECIMAL,
    L_RETURNFLAG    CHAR(1),
    L_LINESTATUS    CHAR(1),
    L_SHIPDATE        DATE,
    L_COMMITDATE    DATE,
    L_RECEIPTDATE    DATE,
    L_SHIPINSTRUCT    CHAR(25),
    L_SHIPMODE        CHAR(10),
    L_COMMENT        VARCHAR(44)
)LOCATION ('gpfdist://172.30.11.101:8082/lineitem_csv_*') FORMAT 'CSV' (DELIMITER '|' NULL '');

5.数据加载入库：
tpch=# copy nation(n_nationkey,n_name,n_regionkey,n_comment) from '/home/gpadmin/nation.csv' delimiter '|' null '';
tpch=# copy region(r_regionkey,r_name,r_comment) from '/home/gpadmin/region.csv' delimiter '|' null '';
tpch=# insert into customer select * from customer_ext;
INSERT 0 45000000
Time: 69426.732 ms
tpch=# insert into supplier select * from supplier_ext
tpch-# ;
INSERT 0 3000000
Time: 7163.869 ms
tpch=# insert into part select * from part_ext;
INSERT 0 60000000
Time: 73583.528 ms
tpch=# insert into partsupp select * from partsupp_ext;
INSERT 0 240000000
Time: 282364.664 ms
将集群中的104剔除，增加106节点后，入库性能大幅提升，如下：
tpch=# insert into customer select * from customer_ext;
INSERT 0 45000000
Time: 13210.282 ms
tpch=# insert into supplier select * from supplier_ext
tpch-# ;
INSERT 0 3000000
Time: 1020.861 ms
tpch=# insert into part select * from part_ext;
INSERT 0 60000000
Time: 14112.276 ms
tpch=# insert into partsupp select * from partsupp_ext;
INSERT 0 240000000
Time: 74765.564 ms
tpch=# insert into orders select * from orders_ext;
INSERT 0 450000000
Time: 122219.725 ms
tpch=# insert into lineitem select * from lineitem_ext;
INSERT 0 1799989091
Time: 747936.667 ms

6.创建索引(使用/Users/chris/tpch/2.17.2/dbgen/dss/ps_tpch_dbinit.sql中的创建索引语句）
CREATE INDEX IDX_NATION_REGIONKEY ON NATION (N_REGIONKEY);
CREATE INDEX IDX_SUPPLIER_NATION_KEY ON SUPPLIER (S_NATIONKEY);
CREATE INDEX IDX_CUSTOMER_NATIONKEY ON CUSTOMER (C_NATIONKEY);
CREATE INDEX IDX_PARTSUPP_PARTKEY ON PARTSUPP (PS_PARTKEY);
CREATE INDEX IDX_PARTSUPP_SUPPKEY ON PARTSUPP (PS_SUPPKEY);
 CREATE INDEX IDX_ORDERS_CUSTKEY ON ORDERS (O_CUSTKEY);
CREATE INDEX IDX_ORDERS_ORDERKEY1 ON ORDERS using btree (O_ORDERKEY);
 CREATE INDEX IDX_ORDERS_ORDERDATE ON ORDERS (O_ORDERDATE);
CREATE INDEX IDX_LINEITEM_ORDERKEY ON LINEITEM using btree (L_ORDERKEY);
CREATE INDEX IDX_LINEITEM_PART_SUPP ON LINEITEM (L_PARTKEY,L_SUPPKEY);
CREATE INDEX IDX_LINEITEM_SHIPDATE ON LINEITEM (L_SHIPDATE, L_DISCOUNT, L_QUANTITY);


7.analyze
tpch=# analyze;
ANALYZE

8.执行测试脚本














