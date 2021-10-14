#!/bin/bash

RESULTS=$1/1_generate_data
SF=$2
LOGFILE=generate_data.log

for (( c=0;c<=9;c++ ))
do
  cp ./dss/q${SF}/11.sql ./dss/queries${c}/
done

#create initdata log
rm -rf $1
rm -rf $RESULTS
mkdir -p $RESULTS

echo "THE TPC-H GENERATE DATA BEGIN-------------"

#delete old data file
echo  "drop the old tbl files-------"
rm -rf $TPCH_HOME/*.tbl 2>>$RESULTS/$LOGFILE

#create new data file
echo  "generate the SF data files now-------"
$TPCH_HOME/dbgen -s $SF 2>>$RESULTS/$LOGFILE

#modify the data files for Greenplum
echo  "modify the data file for Greenplum------"
for i in `ls *.tbl`;
do
 echo "Now modify file's name is: $i" >>$RESULTS/$LOGFILE
# sed  's/|$//' $i > ${i/tbl/csv} 2>>$RESULTS/$LOGFILE
 sed -i 's/|$//' $i 2>>$RESULTS/$LOGFILE &
done

echo "THE TPC-H GENERATE DATA WAS FINISHED-----------"

LOGFILE=generate_sql.log


#drop the RF DATA path
rm -rf $TPCH_HOME/dss/rf_data
mkdir -p $TPCH_HOME/dss/rf_data
RF_DATA=$TPCH_HOME/dss/rf_data
echo "The RF_DATA PATH is :$RF_DATA.......... "

echo "------------------------generate the query begin-----------------------"
echo "generate the query sql begin.......................now"

#drop all the old queries filesystem
#rm -rf $TPCH_HOME/dss/queries*

#generate sql dirctory  $tpch_home/dss/
#for n in `seq 1 $STREAMS`;
#for n in `seq 1 1`;
#do
#  echo "--------generate the new query path $TPCH_HOME/dss/queries$n"
#  mkdir -p $TPCH_HOME/dss/queries$n
#  echo "--------begin to generate query sql"
#  echo "--------generate the $n's query"
  #generate the sql
#  for i in `seq 1 22`;
#  do
#    DSS_QUERY=dss/templates ./qgen $i >> $TPCH_HOME/dss/queries$n/$i.sql
#    sleep 1
#  done
#done

echo "--------------------------------------------generate the query end--------------------------------------------"

#--------------------------------THE PART OF RF DATA&SQL------------------------------------------
echo "---------------------generate the RF data begin-----------------------------------"
echo "generate the RF data  begin................................now"

#drop the old datafile
rm -rf $TPCH_HOME/delete.*
rm -rf $TPCH_HOME/lineitem.tbl.u*
rm -rf $TPCH_HOME/orders.tbl.u*

#begin to generate the rf data
echo "begin to generate the rf data-------------------"
$TPCH_HOME/dbgen -U $STREAMS -s $SF 2>$RESULTS/$LOGFILE
echo "generate the rf data was fineshed---------------"

#modify the rf data file used for Greenplum
echo "begin to modify the rf data file used for Greenplum --------------------"
for i in `seq 1 $STREAMS`
do
   echo "Modify the RF datafile :delete.$i"
   sed -i 's/|$//' $TPCH_HOME/delete.$i 2>>$RESULTS/$LOGFILE &
   echo "Modify the RF datafile :lineitem.tbl.u$i"
   sed -i 's/|$//' $TPCH_HOME/lineitem.tbl.u$i 2>>$RESULTS/$LOGFILE &
   echo "Modify the RF datafile :orders.tbl.u$i"
   sed -i 's/|$//' $TPCH_HOME/orders.tbl.u$i 2>>$RESULTS/$LOGFILE &
done

wait

echo "the rf data was finished-----------------"
