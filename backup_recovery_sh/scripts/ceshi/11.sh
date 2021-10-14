#!/bin/bash

psql -f st.sql >> log.log 2>&1
x=`echo $?`
echo $x
