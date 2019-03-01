#!/bin/bash
echo 'Please Enter your New record' 
cols=`awk 'END {print NR}' Databases/$database_name/meta_$table_name`
col_name=(`awk -F: '{print $1}' Databases/$database_name/meta_$table_name`)
col_types=(`awk -F: '{print $2}' Databases/$database_name/meta_$table_name`)
num1=0
num2=0
count=0
while [[ $num1 -lt $cols ]]
do
    read -p "please your new ${col_name[$num1]} : " new_record[$num1]
    case ${col_types[$num1]} in
    key)
        count=`cut -d: -f1 Databases/$database_name/$table_name | grep -cw ${new_record[$num1]}`
        if test $count -eq 0 
        then
            myrecord[$num1]=${new_record[$num1]}
        else 
            echo "Unvalid ${col_name[$num1]} .... " 
            myrecord[$num1]=0
            continue
        fi 
        echo ${myrecord[$num1]}
        ;; 
    string)
        if [[ ${new_record[$num1]} =~ (^[a-Z]+$) ]]; 
        then
            myrecord[$num1]=${new_record[$num1]}
        else
            echo "Unvalid ${col_name[$num1]} ...." 
            myrecord[$num1]=0
            continue
        fi
        echo ${myrecord[$num1]}
        ;;
    number)
        if [[ ${new_record[$num1]} =~ (^[0-9]+$) ]]; 
        then
            myrecord[$num1]=${new_record[$num1]}
        else
            echo "Unvalid ${col_name[$num1]} ..." 
            myrecord[$num1]=0
            continue
        fi
        echo ${myrecord[$num1]}
        ;;
    *)
    echo nonono
    ;;
    esac
    ((num1=num1+1))
done
((col2=$cols-1))

while [[ $num2 -lt $cols ]]
do
    printf "${myrecord[$num2]}">>Databases/$database_name/$table_name
    if test $num2 -lt $col2
    then
        printf ':'>>Databases/$database_name/$table_name
    fi
    ((num2=num2+1))
done
printf '\n'>>Databases/$database_name/$table_name




