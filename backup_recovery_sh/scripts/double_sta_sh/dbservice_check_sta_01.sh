#放到备库执行，测试开始之前检查数据库状态并备份data
for((;;))
do
  #check_db_service=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select 1" | sed -n "3p" | awk '{print $1}'`
  #执行一句select 1
  $PGHOME/bin/psql -c "select 1" > /dev/null 2>&1
  #取执行状态的返回id
  dbservice_sta_id_01=`echo $?`
  #执行状态id为0说明psql执行正确，数据库状态正常
  if [ $dbservice_sta_id_01 -eq 0 ]
    then
      echo -e "The HighGo Database service\t.............ok"
      #关闭数据库
      $PGHOME/bin/pg_ctl stop -D $PGDATA -m fast
      echo -e "Shut down HighGo database service\t.............ok"
    #如果执行psql返回为1，说明sql执行结果不正确，返回了ERROR等信息，检查脚本
    elif [ $dbservice_sta_id_01 -eq 1 ]
      then
        echo -e "Please check the script for service check SQL\t.............no" 
        #read
        sleep 2
        continue
    #如果执行psql状态返回为2，说明数据库已关闭，压缩备份data
    elif [ $dbservice_sta_id_01 -eq 2 ]
      then
        echo -e "The HighGo Database service\t.............no"
        #判断data目录是否存在
        if [ -e $PGHOME/data -a -d $PGHOME/data ]
          then
            #data目录存在则向日志文件中输入操作日志，执行时间，备份压缩data，跳出for循环
            #cp -rv $PGHOME/data $PGHOME/data_doublewal_sta_`date +%Y-%m%d-%H%M%S`
            echo -e "Backup the directory data\t.............ok"
            break
          else
            #data目录不存在则data已被损坏，检查相关文件
            echo -e "The directory data does not exist,please check\t.............no"
            #read
            sleep 2 
            continue
        fi
    #如果psql执行的返回状态不是0，1，2，则说明出现了未知的错误
    else
      echo -e "Unknown Error,please check the HighGo Database and script for service check SQL\t.............no"
      sleep 2
      continue
  fi
done
