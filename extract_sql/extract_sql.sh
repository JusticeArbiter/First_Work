#!/bin/bash

#数据库环境变量
export PGHOME=/home/postgres/pg9510
export PGDATA=$PGHOME/data
export PATH=$PATH:$PGHOME/bin
export LD_LIRARY_PATH=$LD_LIBRARY_PATH:$PGHOME/lib
export PGHOST=localhost
export PGPORT=5432
export PGUSER=postgres
export PGDATABASE=postgres

#提取sql的脚本运行目录环境变量
export EXTRACT_DIR=/home/postgres/extract_sql
export SQL_INPUT=$EXTRACT_DIR/sql_input
export SQL_MESSAGE=$EXTRACT_DIR/sql_message
export SQL_OUT=$EXTRACT_DIR/sql_out
export SQL_EXPECTED=$EXTRACT_DIR/sql_expected

#修改数据库配置

$PGHOME/bin/pg_ctl stop -w -D $PGDATA

rm -rf $PGHOME/data/*

$PGHOME/bin/initdb -D $PGDATA

echo -e "log_destination = 'csvlog'" >> $PGDATA/postgresql.conf 2>&1
echo -e "logging_collector = on" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_directory = 'pg_log'" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_filename = 'postgresql.log'" >> $PGDATA/postgresql.conf 2>&1
echo -e "client_min_messages = log" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_min_messages = info" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_min_error_statement = info" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_error_verbosity = verbose" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_statement = 'all'" >> $PGDATA/postgresql.conf 2>&1

$PGHOME/bin/pg_ctl start -w -D $PGDATA

#新建插件、外部服务器，外部表在postgres数据库上，创建测试库时继承postgres库
$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -c "create extension file_fdw;"
$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -c "create server hg_server foreign data wrapper file_fdw;"
$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -c "create foreign table postgres_log(
  log_time timestamp(3) with time zone,
  user_name text,
  database_name text,
  process_id integer,
  connection_from text,
  session_id text,
  session_line_num bigint,
  command_tag text,
  session_start_time timestamp with time zone,
  virtual_transaction_id text,
  transaction_id bigint,
  error_severity text,
  sql_state_code text,
  message text,
  detail text,
  hint text,
  internal_query text,
  internal_query_pos integer,
  context text,
  query text,
  query_pos integer,
  location text,
  application_name text
) 
server hg_server 
options(filename '$PGHOME/data/pg_log/postgresql.csv',format 'csv');" 
$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -c "create database regress template postgres;"

#清空输出目录下的文件，避免有多余文件影响
rm -rf $SQL_MESSAGE/*
rm -rf $SQL_OUT/*
rm -rf $SQL_EXPECTED/*

#定义变量n，用以作为各个输出sql文件夹的序列号
n=1

#对sql脚本逐个执行，同时输出message、out文件并且逐行输出到expected文件夹下
for input_sqlfile in `ls $SQL_INPUT | sort`
do

  echo -e "$n. ${input_sqlfile}"

  #FileName=`echo ${SQLFile} | awk -F "/" '{print $3}' | awk -F "." '{print $1}'`
  
  #文件名
  filename=${input_sqlfile%.sql}
  #加上前缀序列号的文件名
  new_filename=${n}_${filename}

#    $PGHOME/bin/psql -U postgres -d postgres -c "drop database if exists regress;"
#    $PGHOME/bin/psql -U postgres -d postgres -c "create database regress template postgres;"

  #每次测试前清空postgresql.csv日志
  cat /dev/null > $PGDATA/pg_log/postgresql.csv

  #执行sql脚本，把输出结果舍弃
  $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d regress < $SQL_INPUT/${input_sqlfile} > /dev/null 2>&1

  #从外部表中查询刚刚执行的sql命令，输出到message下
  $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d regress -t -c "select message from postgres_log where query is null;" > $SQL_MESSAGE/${new_filename}.mes 2>&1

  #对message下的sql脚本进行格式处理，输出到out下
#  cat $SQL_MESSAGE/${new_filename}.mes | sed -e '/^$/d' | sed 's/statement: //g' | sed 's/[[:space:]]\+/ /g' | awk -v RS="" '{gsub("\+\n","");print}' | sed -e '/select message from postgres_log where query is null;/d' > $SQL_OUT/${new_filename}.out 2>&1

#  cat $SQL_MESSAGE/${new_filename}.mes | sed -e '/^$/d' | sed 's/ statement: //g' | sed 's/[[:space:]]\+/ /g' | gawk -v RS="" '{gsub("\+\n","");print}' | sed -e '/select message from postgres_log where query is null;/d' | sed 's/truncate /truncate table /g' | sed 's/TRUNCATE /TRUNCATE TABLE /g' | sed 's/TRUNCATE TABLE TABLE /TRUNCATE TABLE /g' | sed 's/AFTER TRUNCATE TABLE /AFTER TRUNCATE /g' | sed 's/BEFORE TRUNCATE TABLE /BEFORE TRUNCATE /g' > $SQL_OUT/${new_filename}.out 2>&1

  cat $SQL_MESSAGE/${new_filename}.mes | sed -e '/^$/d' | sed 's/ statement: //g' | sed 's/[[:space:]]\+/ /g' | gawk -v RS="" '{gsub("+\n","");print}' | sed -e '/select message from postgres_log where query is null;/d' > $SQL_OUT/${new_filename}.out 2>&1

  #在expected下创建对应执行sql脚本文件名的文件夹
  mkdir $SQL_EXPECTED/${new_filename}

  #rows变量存放处理好的sql文件的行数
  rows=`cat $SQL_OUT/${new_filename}.out | wc -l`
  #输出的sql文件在每个文件夹下以序列号_文件夹名命令
  r=1 
  #把每一行的sql循环输出到sql文件内
  while [ $r -le $rows ]
    do
      tail -n+$r $SQL_OUT/${new_filename}.out | head -1 > $SQL_EXPECTED/${new_filename}/${r}_${filename}.sql 2>&1
      let r+=1
  done
  let n+=1
done

echo ok
