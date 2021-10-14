#放到备库进行文件检查的脚本
for((;;))
do
  let y=0
  for stafile in $*
  do
    if [ -e $stafile -a -f $stafile ]
      then
        echo -e "The standby server file $stafile\t.............ok"
      else
        echo -e "Please check the standby server file $stafile,creation failed\t.............no"
        let y+=1
        sleep 2
        continue
    fi
  done
  if [ $y -eq 0 ]
    then
      break
  fi
done
