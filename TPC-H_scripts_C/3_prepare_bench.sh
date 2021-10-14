#!/bin/bash

RESULTS=$1/3_generate_sql
LOGFILE=generate_sql.log

#generate the log path
rm -rf $RESULTS
mkdir -p $RESULTS

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
   sed -i 's/|$//' $TPCH_HOME/delete.$i 2>>$RESULTS/$LOGFILE
   echo "Modify the RF datafile :lineitem.tbl.u$i"
   sed -i 's/|$//' $TPCH_HOME/lineitem.tbl.u$i 2>>$RESULTS/$LOGFILE
   echo "Modify the RF datafile :orders.tbl.u$i"
   sed -i 's/|$//' $TPCH_HOME/orders.tbl.u$i 2>>$RESULTS/$LOGFILE
done
echo "the rf data was finished-----------------"