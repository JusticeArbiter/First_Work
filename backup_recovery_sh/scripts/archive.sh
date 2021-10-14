#!/bin/bash

#归档备份恢复，也可称为增量备份恢复
function archive(){
#删除增量备份恢复文件夹下的所有文件
echo
echo -e "Empty the directory $ARCHIVE_DIR\t............."
rm -rf $ARCHIVE_DIR/*
empty_dir_check $ARCHIVE_DIR

#创建归档备份项目下的文件夹
echo -e "Create the directory\t............."
mkdir $ARCHIVE_DIR/log
mkdir $ARCHIVE_DIR/data_backup
mkdir $ARCHIVE_DIR/arch_command
#检查目录是否创建成功
check_dir $ARCHIVE_DIR/log $ARCHIVE_DIR/data_backup $ARCHIVE_DIR/arch_command

#备份data的新名字变量，易于区分各个项目之间的data备份
daname_ba=archive

#测试前数据库状态检查，备份原data
dbservice_check_01 $ARCHIVE_DIR/log/log.log

#删除data目录
echo -e "Delete the directory $PGHOME/data\t............."
output_log $ARCHIVE_DIR/log/log.log "rm -rf $PGHOME/data"
delete_dir_check $PGHOME/data

#初始化数据库
echo -e "Init the HighGo Database\t............."
output_log $ARCHIVE_DIR/log/log.log "initdb_stat"
command_returnid_check $command_return_id "Initdb(HighGo Database)..."
check_dir $PGHOME/data

#备份配置文件
echo -e "Backup the database configuration file\t............."
output_log $ARCHIVE_DIR/log/log.log "mv $PGHOME/data/pg_hba.conf $PGHOME/data/pg_hba.conf.back"
output_log $ARCHIVE_DIR/log/log.log "cp $PGHOME/data/postgresql.conf $PGHOME/data/postgresql.conf.back"
check_file $PGHOME/data/pg_hba.conf.back $PGHOME/data/postgresql.conf.back

#修改数据库参数
echo -e "Modifying database configuration\t............."

echo -e "local all all trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e local all all trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all 127.0.0.1/32 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e host all all 127.0.0.1/32 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all ::1/128 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e host all all ::1/128 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "Modify the file $PGHOME/data/pg_hba.conf\t.............ok"

echo -e "logging_collector = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e logging_collector = on >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_directory = 'hgdb_log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e log_directory = 'hgdb_log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_filename = 'hgdb_archive-%Y-%m-%d_%H%M%S.log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e log_filename = 'hgdb_archive-%Y-%m-%d_%H%M%S.log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "wal_level=archive" >> $PGHOME/data/postgresql.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e wal_level = archive >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "archive_mode = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e archive_mode = on >> $PGHOME/data/postgresql.conf 2>&1"

#echo -e "archive_command = 'cp %p $ARCHIVE_DIR/arch_command/%f'" >> $PGHOME/data/postgresql.conf 2>&1
#output_log $ARCHIVE_DIR/log/log.log "echo -e archive_command = 'cp %p $ARCHIVE_DIR/arch_command/%f' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "archive_directory = '$ARCHIVE_DIR/arch_command/'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e archive_directory = '$ARCHIVE_DIR/arch_command/' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "Modify the file $PGHOME/data/postgresql.conf\t.............ok"

#启动数据库服务
echo -e "Start the HighGo Databse service\t............."
output_log $ARCHIVE_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"
dbservice_check_02

#进行一次基础备份
echo -e "Start a base backup\t............."
output_log $ARCHIVE_DIR/log/log.log "$SCR_SQL_DIR/base_start.sh"
command_returnid_check $command_return_id "select pg_start_backup()"

output_log $ARCHIVE_DIR/log/log.log "cp -rv $PGHOME/data $ARCHIVE_DIR/data_backup/data_base"
check_dir $ARCHIVE_DIR/data_backup/data_base

output_log $ARCHIVE_DIR/log/log.log "$SCR_SQL_DIR/base_stop.sh"
command_returnid_check $command_return_id "select pg_stop_backup()"
echo -e "Base backup succeeded\t.............ok"

#使用内置工具pgbench插入数据
echo -e "Importing test data using pgbench\t............."
output_log $ARCHIVE_DIR/log/log.log "$PGHOME/bin/pgbench -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -i -s 10"
command_returnid_check $command_return_id "pgbench -i -s 10"

#第一次聚合查询
validation_count_07=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
output_important_text "The first query result is $validation_count_07"

#强制kill数据库进程
echo -e "Kill the HighGo Database service\t............."
highgo_service_id_02=`ps -ef | grep "$PGHOME/bin/postgres" | head -1 | awk '{print $2}'`
output_log $ARCHIVE_DIR/log/log.log "kill -9 $highgo_service_id_02"
dbservice_check_03

#备份数据库宕机之后的data目录
echo -e "Backup the directory data\t............."
output_log $ARCHIVE_DIR/log/log.log "cp -rv $PGHOME/data $ARCHIVE_DIR/data_backup/data_stop"
check_dir $ARCHIVE_DIR/data_backup/data_stop

#删除数据库的data目录
echo -e "Delete the directory $PGHOME/data\t............."
output_log $ARCHIVE_DIR/log/log.log "rm -rf $PGHOME/data"
delete_dir_check $PGHOME/data

#恢复data
echo -e "Restoring the directory data\t............."
output_log $ARCHIVE_DIR/log/log.log "cp -rv $ARCHIVE_DIR/data_backup/data_base $PGHOME/data"
check_dir $PGHOME/data

#清空pg_xlog
echo -e "Empty the directory pg_xlog\t............."
output_log $ARCHIVE_DIR/log/log.log "rm -rf $PGHOME/data/pg_xlog/*"
empty_dir_check $PGHOME/data/pg_xlog

#恢复pg_xlog
echo -e "Restoring the directory pg_xlog\t............."
output_log $ARCHIVE_DIR/log/log.log "cp -rv $ARCHIVE_DIR/data_backup/data_stop/pg_xlog/* $PGHOME/data/pg_xlog/"
echo -e "Restoring the directory pg_xlog\t.............ok"

#创建recovery.conf文件
#echo -e "Create file recovery.conf,write restoring infotmation\t............."
#echo -e "restore_command = 'cp $ARCHIVE_DIR/arch_command/%f %p'" > $PGHOME/data/recovery.conf 2>&1
#output_log $ARCHIVE_DIR/log/log.log "echo -e restore_command = 'cp $ARCHIVE_DIR/arch_command/%f %p' > $PGHOME/data/recovery.conf 2>&1"
#check_file $PGHOME/data/recovery.conf

echo -e "Create file recovery.conf,write restoring infotmation\t............."
echo -e "archive_directory = '$ARCHIVE_DIR/arch_command/'" > $PGHOME/data/recovery.conf 2>&1
output_log $ARCHIVE_DIR/log/log.log "echo -e archive_directory = '$ARCHIVE_DIR/arch_command/' > $PGHOME/data/recovery.conf 2>&1"
check_file $PGHOME/data/recovery.conf



#启动数据库服务，开始从归档中恢复数据
echo -e "Start the HighGo Database service\t............."
output_log $ARCHIVE_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"

#检查recovery.conf文件是否修改位recovery.done
check_file $PGHOME/data/recovery.done
dbservice_check_02

#查询结果，与原始结果对比，第二次聚合查询
validation_count_08=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
output_important_text "The second query result is $validation_count_08"
if [ $validation_count_07 -eq $validation_count_08 ]
  then
    output_important_text "The archive backup recovery testing success\t.............ok"
  else
    outptu_important_text "The archive backup recovery test failed\t.............no "
    exit 1
fi

#停止数据库服务，便于data备份
echo -e "Stoping the database service\t............."
output_log $ARCHIVE_DIR/log/log.log "$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data -m fast"
dbservice_check_03

#备份最终的data
echo -e "Backup the last data\t............."
output_log $ARCHIVE_DIR/log/log.log "cp -rv $PGHOME/data $ARCHIVE_DIR/data_backup/data_end"
check_dir $ARCHIVE_DIR/data_backup/data_end
echo -e "Backup the last data to directory $ARCHIVE_DIR/data_backup/data_end\t.............ok"

echo -e "$encry_cho $fdefenji archive : ok" >> $LOG_DIR/log.log

#read
}
