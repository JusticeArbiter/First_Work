#!/bin/bash

aa=`date +%Y-%m%d-%H%M%S`
touch  hgdb_`date +%Y-%m%d-%H%M%S`

phy(){
echo -e "phy...ok";}
logic(){
echo -e "logic...ok";}
incre(){
echo -e "incre...ok";}
double(){
echo -e "double...ok";}

for ((;;))
do
  echo -e "\t1 phy"
  echo -e "\t2 logic"
  echo -e "\t3 incre"
  echo -e "\t4 double"
  echo -e "\t5 exit"
  read m
  case $m in
    1) 
      phy
      ;;
    2)
      logic
      ;;
    3) 
      incre
      ;;
    4)
      double
      ;;
    5)
      break
      ;;
  esac
done

