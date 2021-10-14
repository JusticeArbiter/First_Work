#!/bin/bash

#物理冷备份恢复(停止数据库服务备份data，删除之后恢复回来)
function physics_cold(){
#删除物理冷备份恢复文件夹下的所有文件
echo
echo -e "Empty the directory $PHYCOLD_DIR\t............."
rm -rf $PHYCOLD_DIR/*
empty_dir_check $PHYCOLD_DIR

#创建物理备份恢复项目下的各个文件夹
echo -e "Create the directory\t............."
mkdir $PHYCOLD_DIR/log
mkdir $PHYCOLD_DIR/data_backup
#检查目录是否创建成功
check_dir $PHYCOLD_DIR/log $PHYCOLD_DIR/data_backup

#备份data的新名字变量，易于区分各个项目之间的data备份
daname_ba=physicscold

#开始测试前数据库状态检查，备份原data
dbservice_check_01 $PHYCOLD_DIR/log/log.log

#删除data目录
echo -e "Delete the directory $PGHOME/data\t............."
output_log $PHYCOLD_DIR/log/log.log "rm -rf $PGHOME/data"
delete_dir_check $PGHOME/data

#初始化数据库
echo -e "Init the HighGo Database\t............."
output_log $PHYCOLD_DIR/log/log.log "initdb_stat"
command_returnid_check $command_return_id "Initdb(HighGo Database)..."
check_dir $PGHOME/data

#备份配置文件
echo -e "Backup the database configuration file\t............."
output_log $PHYCOLD_DIR/log/log.log "mv $PGHOME/data/pg_hba.conf $PGHOME/data/pg_hba.conf.back"
output_log $PHYCOLD_DIR/log/log.log "cp $PGHOME/data/postgresql.conf $PGHOME/data/postgresql.conf.back"
check_file $PGHOME/data/pg_hba.conf.back $PGHOME/data/postgresql.conf.back

#修改数据库参数
echo -e "Modifying database configuration\t............."

echo -e "local all all trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $PHYCOLD_DIR/log/log.log "echo -e local all all trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all 127.0.0.1/32 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $PHYCOLD_DIR/log/log.log "echo -e host all all 127.0.0.1/32 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all ::1/128 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $PHYCOLD_DIR/log/log.log "echo -e host all all ::1/128 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "Modify the file $PGHOME/data/pg_hba.conf\t.............ok"

echo -e "logging_collector = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $PHYCOLD_DIR/log/log.log "echo -e logging_collector = on >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_directory = 'hgdb_log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $PHYCOLD_DIR/log/log.log "echo -e log_directory = 'hgdb_log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_filename = 'hgdb_phycold-%Y-%m-%d_%H%M%S.log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $PHYCOLD_DIR/log/log.log "echo -e log_filename = 'hgdb_phycold-%Y-%m-%d_%H%M%S.log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "Modify the file $PGHOME/data/postgresql.conf\t.............ok"

#启动数据库服务
echo -e "Start the HighGo Databse service\t............."
output_log $PHYCOLD_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"
dbservice_check_02

#使用内置工具pgbench插入数据
echo -e "Importing test data using pgbench\t............."
output_log $PHYCOLD_DIR/log/log.log "$PGHOME/bin/pgbench -h $PGHOST -p $PGPORT -U $PGUSER -i -s 10 $PGDATABASE"
command_returnid_check $command_return_id "pgbench -i -s 10"

#第一次聚合查询
validation_count_03=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
output_important_text "The first query result is  $validation_count_03"

#停止数据库服务
echo -e "Stoping the HighGo Database service\t............."
output_log $PHYCOLD_DIR/log/log.log "$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data -m fast"
dbservice_check_03

#备份data到冷备的data_backup目录下
echo -e "Backup the directory data\t............."
output_log $PHYCOLD_DIR/log/log.log "cp -rv $PGHOME/data $PHYCOLD_DIR/data_backup/data_phycold"
check_dir $PHYCOLD_DIR/data_backup/data_phycold

#删除数据库data目录
echo -e "Delete the directory $PGHOME/data\t............."
output_log $PHYCOLD_DIR/log/log.log "rm -rf $PGHOME/data"
delete_dir_check $PGHOME/data

#恢复data目录
echo -e "Restoring the directory data\t............."
output_log $PHYCOLD_DIR/log/log.log "cp -rv $PHYCOLD_DIR/data_backup/data_phycold $PGHOME/data"
check_dir $PGHOME/data

#启动数据库服务
echo -e "Start the HighGo Database service\t............."
output_log $PHYCOLD_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"
dbservice_check_02

#查询结果，与原始结果对比，第二次聚合查询
validation_count_04=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
output_important_text "The second query result is $validation_count_04"
if [ $validation_count_03 -eq $validation_count_04 ]
  then
    output_important_text "The physical cold backup and recovery testing success\t.............ok"
  else
    output_important_text "The physical cold backup and recovery test failed\t.............no"
    exit 1
fi

#停止数据库服务，便于data备份
echo -e "Stoping the database service\t............."
output_log $PHYCOLD_DIR/log/log.log "$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data -m fast"
dbservice_check_03

#备份最终的data
echo -e "Backup the last data\t............."
output_log $PHYCOLD_DIR/log/log.log "cp -rv $PGHOME/data $PHYCOLD_DIR/data_backup/data_end"
check_dir $PHYCOLD_DIR/data_backup/data_end
echo -e "Backup the last data to directory $PHYCOLD_DIR/data_backup/data_end\t.............ok"

echo -e "$encry_cho $fdefenji physics_cold : ok" >> $LOG_DIR/log.log 2>&1

#read
}
