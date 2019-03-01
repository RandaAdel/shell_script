#!/bin/bash
flag=`ls Databases/$database_name|find -type f|grep ^./$table_name$`;
if [ -n "$flag" ];		#check if it exists 
then
  echo please enter your record primary key 
  read select
  if [ -n `grep -w "$select" Databases/$database_name/$table_name` ]
  then 
   echo `grep -w "$select" Databases/$database_name/$table_name`;
  fi
  if [ -z `grep -w "$select" Databases/$database_name/$table_name` ]
  then 
   echo "There is no match";
  fi
else 
  echo "There is no such table"
fi
