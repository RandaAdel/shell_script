#!/bin/bash
echo Enter table_name
read table_name
flag=`ls Databases/$database_name|find -type f|grep ^~/$table_name$`;
while [ -n "$flag" ];		#check if it exists 
do
  echo $table_name is already taken, choose different name
  read table_name
  flag=`ls Databases/$database_name|find -type f|grep ^./$table_name$`;
done
touch Databases/$database_name/$table_name				#create table file
touch Databases/$database_name/meta_$table_name				#create meta file 
ans=y
while [[ "$ans" != "n" ]];  
do
  echo enter your column names
  read -a columns				#enter any number of columns' Names
  echo "enter your columns' types (key or string or number)"
  echo ${columns[@]} 
  read -a types					#enter columns' types
  for i in $(seq 0 1 ${#columns[@]})
  do	
    printf "${columns[i]}:${types[i]}\n">>Databases/$database_name/meta_$table_name 
  done
  sed -i '$d' Databases/$database_name/meta_$table_name		#delete last empty line 
  echo Do you want to add other columns? y/n  
  read ans 
done  
echo $table_name table created successfully


