#放到备库执行检查数据库服务是否关闭成功
for((;;))
do
  $PGHOME/bin/psql -c "select 1" > /dev/null 2>&1
  dbservice_sta_id_03=`echo $?`
  if [ $dbservice_sta_id_03 -eq 0 ]
    then
      echo -e "Stop the Master(old standby) server HighGo Database service failed,please check\t.............no"
      sleep 2
      continue 
    else
      echo -e "Stop the Master(old standby) server HighGo Database service successfully\t.............ok"
      break
  fi
done
