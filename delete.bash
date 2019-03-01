#!/bin/bash
typeset -i input
echo 'Please Enter ID'
read input
sed -i "/^${input}:/d" Databases/$database_name/$table_name
echo "Record ${input} is Deleted"


