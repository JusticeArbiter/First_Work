#!/bin/bash

#数据库环境变量
export PGHOME=/home/postgres/pg956
export PGDATA=$PGHOME/data
export PATH=$PATH:$PGHOME/bin
export LD_LIRARY_PATH=$LD_LIBRARY_PATH:$PGHOME/lib
export PGHOST=localhost
export PGPORT=5432
export PGUSER=highgo
export PGDATABASE=highgo

#生成结果目录环境变量
export BUILD_DIR=/home/postgres/build_out
export SQL_DIR=$BUILD_DIR/sql
export OUT_DIR=$BUILD_DIR/out
export OUT_LOG=$BUILD_DIR/log

#运行之前清空输出目录
rm -rf $OUT_LOG/*
rm -rf $OUT_DIR/*

#循环执行每一个sql文件夹
for sql_dir in `ls $BUILD_DIR/sql/ | sort -n`
  do
    
    echo $sql_dir >> $OUT_LOG/dir.log 2>&1
    
    #创建sql文件夹对应的输出文件夹
    mkdir $OUT_DIR/$sql_dir
    
    #循环执行每个文件夹下的每个sql文件
    for sql_file in `ls $BUILD_DIR/sql/$sql_dir | sort -n`
      do
      
        echo $sql_file >> $OUT_LOG/file.log 2>&1
        
        #提取文件名字
        filename=${sql_file%.sql}

        #输出结果到指定目录的指定文件下，并去除结果中含有sql文件绝对路径的内容，方便后期作为期望输出与实际输出进行对比
        $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -f $SQL_DIR/$sql_dir/$sql_file 2>&1 | sed 's/^psql.*ERROR/ERROR/g' 2>&1 | sed 's/^psql.*WARNING/WARNING/g' 2>&1 | sed 's/^psql.*NOTICE/NOTICE/g' 2>&1 | sed 's/^psql.*invalid/invalid/g' | sed 's/^psql.*INFO/INFO/g' > $OUT_DIR/$sql_dir/${filename}.exp 2>&1
    
    done
done
