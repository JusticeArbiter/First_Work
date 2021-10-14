#!/bin/bash

#逻辑备份恢复，备份之后删除数据库，执行恢复
function logic(){
#删除逻辑备份恢复文件夹下的所有文件
echo
echo -e "Empty the directory $LOGIC_DIR\t............."
rm -rf $LOGIC_DIR/*
empty_dir_check $LOGIC_DIR

#创建逻辑备份项目下的文件夹
echo -e "Create the directory\t............."
mkdir $LOGIC_DIR/log
mkdir $LOGIC_DIR/data_backup
mkdir $LOGIC_DIR/backup_file
#检查目录是否创建成功
check_dir $LOGIC_DIR/log $LOGIC_DIR/data_backup $LOGIC_DIR/backup_file

#备份data的新名字变量，易于区分各个项目之间的data备份
daname_ba=logic

#测试前数据库状态检查，备份原data
dbservice_check_01 $LOGIC_DIR/log/log.log

#删除data目录
echo -e "Delete the directory $PGHOME/data\t............."
output_log $LOGIC_DIR/log/log.log "rm -rf $PGHOME/data"
delete_dir_check $PGHOME/data

#初始化数据库
echo -e "Init the HighGo Database\t............."
output_log $LOGIC_DIR/log/log.log "initdb_stat"
command_returnid_check $command_return_id "Initdb(HighGo Database)..."
check_dir $PGHOME/data

#备份配置文件
echo -e "Backup the database configuration file\t............."
output_log $LOGIC_DIR/log/log.log "mv $PGHOME/data/pg_hba.conf $PGHOME/data/pg_hba.conf.back"
output_log $LOGIC_DIR/log/log.log "cp $PGHOME/data/postgresql.conf $PGHOME/data/postgresql.conf.back"
check_file $PGHOME/data/pg_hba.conf.back $PGHOME/data/postgresql.conf.back

#修改数据库参数
echo -e "Modifying database configuration\t............."

echo -e "local all all trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $LOGIC_DIR/log/log.log "echo -e local all all trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all 127.0.0.1/32 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $LOGIC_DIR/log/log.log "echo -e host all all 127.0.0.1/32 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all ::1/128 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $LOGIC_DIR/log/log.log "echo -e host all all ::1/128 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "Modify the file $PGHOME/data/pg_hba.conf\t.............ok"

echo -e "logging_collector = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $LOGIC_DIR/log/log.log "echo -e logging_collector = on >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_directory = 'hgdb_log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $LOGIC_DIR/log/log.log "echo -e log_directory = 'hgdb_log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_filename = 'hgdb_logic-%Y-%m-%d_%H%M%S.log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $LOGIC_DIR/log/log.log "echo -e log_filename = 'hgdb_logic-%Y-%m-%d_%H%M%S.log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "Modify the file $PGHOME/data/postgresql.conf\t.............ok"

#启动数据库服务
echo -e "Start the HighGo Databse service\t............."
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"
dbservice_check_02

#创建数据库，使用内置工具pgbench插入数据
echo -e "Create the test database\t............."
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/createdb -h $PGHOST -p $PGPORT -U $PGUSER db1"
command_returnid_check $command_return_id "createdb db1"

echo -e "Importing test data using pgbench\t............."
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/pgbench -h $PGHOST -p $PGPORT -U $PGUSER -i -s 10 db1"
command_returnid_check $command_return_id "pgbench -i -s 10"

#第一次聚合查询
validation_count_05=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d db1 -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
output_important_text "The first query result is $validation_count_05"

#使用逻辑备份工具pg_dump备份
echo -e "Backup using the pg_dump tool\t............."
logic_time=`date +%Y-%m%d-%H%M%S`
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/pg_dump -h $PGHOST -p $PGPORT -U $PGUSER --format custom --verbose -w -f $LOGIC_DIR/backup_file/backup_$logic_time db1"
command_returnid_check $command_return_id "pg_dump"
check_file $LOGIC_DIR/backup_file/backup_$logic_time

#删除数据库db1
echo -e "Deleting the test database\t............."
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/dropdb -h $PGHOST -p $PGPORT -U $PGUSER db1"
command_returnid_check $command_return_id "dropdb db1"

#恢复数据库db1
echo -e "Restoring the data using pg_restore tool\t............."
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/pg_restore -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE --create --verbose -w $LOGIC_DIR/backup_file/backup_$logic_time"
command_returnid_check $command_return_id "pg_restore"

#查询结果，与原始结果对比，第二次聚合查询
validation_count_06=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d db1 -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
output_important_text "The second query result is $validation_count_06"
if [ $validation_count_05 -eq $validation_count_06 ]
  then
    output_important_text "The logic backup recovery testing success\t.............ok"
  else
    output_important_text "The logic backup recovery test failed\t.............no "
    exit 1
fi

#停止数据库服务，便于data备份
echo -e "Stoping the database service\t............."
output_log $LOGIC_DIR/log/log.log "$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data -m fast"
dbservice_check_03

#备份最终的data
echo -e "Backup the last data\t............."
output_log $LOGIC_DIR/log/log.log "cp -rv $PGHOME/data $LOGIC_DIR/data_backup/data_end"
check_dir $LOGIC_DIR/data_backup/data_end
echo -e "Backup the last data to directory $LOGIC_DIR/data_backup/data_end\t.............ok"

echo -e "$encry_cho $fdefenji logical : ok" >> $LOG_DIR/log.log

#read
}

