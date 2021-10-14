#放到备库进行文件夹检查的脚本
for((;;))
do
  let z=0
  for stadir in $*
  do
    if [ -e $stadir -a -d $stadir ]
      then
        echo -e "The standby server directory $stadir\t.............ok"
      else
        echo -e "Please check the standby server directory $stadir,creation failed\t.............no"
        let z+=1
        sleep 2
        continue
    fi
  done
  if [ $z -eq 0 ]
    then
      break
  fi
done
