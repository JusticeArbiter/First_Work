#!/bin/bash

#数据库环境变量
export PGHOME=/home/postgres/pg9510
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
export LOG_DIR=$BUILD_DIR/log
export TMP_DIR=$BUILD_DIR/temp

#配置数据库
$PGHOME/bin/pg_ctl stop -w -D $PGDATA

rm -rf $PGHOME/data/*

$PGHOME/bin/initdb -D $PGDATA

echo -e "logging_collector = on" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_directory = 'pg_log'" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_filename = 'postgresql.log'" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_min_messages = info" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_min_error_statement = info" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_error_verbosity = verbose" >> $PGDATA/postgresql.conf 2>&1
echo -e "log_statement = 'all'" >> $PGDATA/postgresql.conf 2>&1


$PGHOME/bin/pg_ctl start -w -D $PGHOME/data

$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U postgres -d postgres -c "create user highgo superuser replication;"
$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U postgres -d postgres -c "create database highgo owner highgo;"

#运行之前清空输出目录
rm -rf $LOG_DIR/*
rm -rf $OUT_DIR/*

#循环执行每一个sql文件夹
for sql_dir in `ls $BUILD_DIR/sql/ | sort -n`
  do
    
    echo -e "$sql_dir"

    echo $sql_dir >> $LOG_DIR/dir.log 2>&1
    
    #创建sql文件夹对应的输出文件夹
    mkdir $OUT_DIR/$sql_dir
    mkdir -p $LOG_DIR/pglog/$sql_dir

    #循环执行每个文件夹下的每个sql文件
    for sql_file in `ls $BUILD_DIR/sql/$sql_dir | sort -n`
      do
      
        echo $sql_file >> $LOG_DIR/file.log 2>&1
        
        #提取文件名字
        filename=${sql_file%.sql}

        #清空日志文件
        cat /dev/null > $PGHOME/data/pg_log/postgresql.log 2>&1

        #$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -f $SQL_DIR/$sql_dir/$sql_file 2>&1 | sed 's/^psql.*ERROR/ERROR/g' 2>&1 | sed 's/^psql.*WARNING/WARNING/g' 2>&1 | sed 's/^psql.*NOTICE/NOTICE/g' 2>&1 | sed 's/^psql.*invalid/invalid/g' | sed 's/^psql.*INFO/INFO/g' > $OUT_DIR/$sql_dir/${filename}.exp 2>&1

        #输出结果到临时文件下，并去除结果中含有sql文件绝对路径的内容，方便后期作为期望输出与实际输出进行对比
        $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -a -f $SQL_DIR/$sql_dir/$sql_file 2>&1 | sed 's/^psql.*ERROR/ERROR/g' | sed 's/^psql.*WARNING/WARNING/g' | sed 's/^psql.*NOTICE/NOTICE/g' | sed 's/^psql.*invalid/invalid/g' | sed 's/^psql.*INFO/INFO/g' > $TMP_DIR/tmp_out.tmp 
         
        for flaginfo in ERROR WARNING NOTICE invalid INFO
        do 

          num_1=`grep -c ^$flaginfo $TMP_DIR/tmp_out.tmp`
          num_2=`grep -c ^$flaginfo $PGHOME/data/pg_log/postgresql.log`

          if [ ${num_1} -eq ${num_2} ]
            then

              grep ^$flaginfo $PGHOME/data/pg_log/postgresql.log > $TMP_DIR/tmp_1.tmp
              
              grep -n ^$flaginfo $TMP_DIR/tmp_out.tmp > $TMP_DIR/tmp_2.tmp
            
              for (( i=1; i<=$num_1; i+=1 ))
              do

                mid=`cat $TMP_DIR/tmp_1.tmp | head -$i | tail -1 | awk -F : '{print $2}' | awk '{print $1}'`
                hid=`cat $TMP_DIR/tmp_2.tmp | head -$i | tail -1 | awk -F : '{print $1}'`
                
                sed -i "${hid}s/^$flaginfo: /$flaginfo:  $mid:/g" $TMP_DIR/tmp_out.tmp

              done
            else
              echo -e "$SQL_DIR/$sql_dir/$sql_file and postgresql.log inconsistent in $flaginfo\t.............no" >> $LOG_DIR/error.log
          fi
        done
 
        cat $TMP_DIR/tmp_out.tmp > $OUT_DIR/$sql_dir/${filename}.exp

        #获取日志中返回的错误ID
#        error_id=`cat $PGHOME/data/pg_log/postgresql.log | grep '^ERROR' | awk -F : '{print $2}' | awk '{print $1}'`
#        warning_id=`cat $PGHOME/data/pg_log/postgresql.log | grep '^WARNING' | awk -F : '{print $2}' | awk '{print $1}'`
#        notice_id=`cat $PGHOME/data/pg_log/postgresql.log | grep '^NOTICE' | awk -F : '{print $2}' | awk '{print $1}'`
#        invalid_id=`cat $PGHOME/data/pg_log/postgresql.log | grep '^invalid' | awk -F : '{print $2}' | awk '{print $1}'`
#        info_id=`cat $PGHOME/data/pg_log/postgresql.log | grep '^INFO' | awk -F : '{print $2}' | awk '{print $1}'`

#        errorid=`echo $error_id | awk '{print $1}'`
#        warningid=`echo $warning_id | awk '{print $1}'`
#        noticeid=`echo $notice_id | awk '{print $1}'`
#        invalidid=`echo $invalid_id | awk '{print $1}'`
#        infoid=`echo $info_id | awk '{print $1}'`

        #格式化输出到目标文件
#        cat $TMP_DIR/tmp.tmp | sed "s/^ERROR: /ERROR:  ${errorid}:/g" | sed "s/^WARNING: /WARNING:  ${warningid}:/g" | sed "s/^NOTICE: /NOTICE:  ${noticeid}:/g" | sed "s/^incalid: /invalid:  ${invalidid}:/g" | sed "s/^INFO: /INFO:  ${infoid}:/g" > $OUT_DIR/$sql_dir/${filename}.exp

#        sed -i "s/^ERROR: /ERROR:  ${errorid}:/g" $TMP_DIR/tmp.tmp
#        sed -i "s/^WARNING: /WARNING:  ${warningid}:/g" $TMP_DIR/tmp.tmp
#        sed -i "s/^NOTICE: /NOTICE:  ${noticeid}:/g" $TMP_DIR/tmp.tmp
#        sed -i "s/^incalid: /invalid:  ${invalidid}:/g" $TMP_DIR/tmp.tmp
#        sed -i "s/^INFO: /INFO:  ${infoid}:/g" $TMP_DIR/tmp.tmp
#        cat $TMP_DIR/tmp.tmp > $OUT_DIR/$sql_dir/${filename}.exp
       cp $PGHOME/data/pg_log/postgresql.log $LOG_DIR/pglog/$sql_dir/${filename}.log
    done
done

echo ok
