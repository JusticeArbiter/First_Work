#!/bin/bash

export LANG=en_US.UTF-8

export TPCH_HOME=/home/sevengod/2.17.3/dbgen
export DBNAME=tpch_100g
export USER=highgo
export PGPORT=5678
export TPCH_LOG=/home/sevengod/tpch_log/100g
export STREAMS=10      #the real streams is: 4 ($STREAMS -1) ,the 1 use for power test.
export SF=100          #the SF scope is [1 10 30 100 300 1000 3000 10000]

rm -rf $TPCH_LOG
mkdir $TPCH_LOG

echo -e "TPCH_HOME IS :$TPCH_HOME \nDBNAME IS :$DBNAME \n$USER IS :$USER \nPORT IS :$PORT \nTPCH_LOG IS :$TPCH_LOG \nSTREAMS IS :$STREAMS \nSF IS :$SF"

echo "the first step is generate data from ./1_generate_data.sh $TPCH_LOG $SF.......now"
#sh $TPCH_HOME/1_generate_data.sh $TPCH_LOG $SF
echo "the first shell was finished.............OK"


echo "the second step is load data to the database ./2_load_data.sh $TPCH_LOG"
sh $TPCH_HOME/2_load_data.sh $TPCH_LOG
echo "the second shell was finished...........OK"


#echo "the third setp is generate the run sql for queries and rf sql ./3_create_sql.sh $TPCH_LOG $STREAMS $SF"
#sh $TPCH_HOME/3_prepare_bench.sh $TPCH_LOG $STREAMS $SF
#echo "the third shell was finished............OK"


echo "the fouth step is run Power test ./4_run_power.sh $TPCH_LOG"
sh $TPCH_HOME/4_run_power.sh $TPCH_LOG
echo "the fouth shell was finished..............OK"

echo "the fifth step is run Throughput test ./5_run_throughput.sh"
sh $TPCH_HOME/5_run_throughput.sh $TPCH_LOG $STREAMS
echo "the fifth shell was finished............OK"
