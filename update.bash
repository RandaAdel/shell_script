#! /bin/bash
flag=`ls Databases/$database_name|find -type f|grep ^./$table_name$`;
while [ -z "$flag" ];		#check if it exists 
do
  echo $table_name is not a table, enter a valid name
  read table_name
  flag=`ls Databases/$database_name|find -type f|grep ^./$table_name$`;
done

echo Enter your row Id
read Id
echo Your columns are $(awk -F: '{print $1}' Databases/$database_name/meta_$table_name)
echo enter column to be updated
read column
 
flag1=`cat Databases/$database_name/meta_$table_name|grep -w "$column"`;

while [ -z "$flag1" ];		#check if it does not exist 
do
  echo $column is is not a column, enter a valid name
  read column
  flag1=`cat Databases/$database_name/meta_$table_name|grep -w "$column"`; 
done

col=`awk -v var="${column}" -F: '{for(i=0; i<NR; i++){if($1==var){var=NR}}} END{print var}' Databases/$database_name/meta_$table_name`

#find number of row to be update 
I_D=`grep -wn "$Id" Databases/$database_name/$table_name | cut -d : -f1`

echo "enter your new value" 
read value

#check data type validation
#type=`awk -v var="${column}" -F: '{for(i=0; i<NR; i++){if($1==var){var=$2}}} END{print var}' ~/Databases/meta_$table_name`

#find the old value matching column and row number entered
#`awk -v var1="${I_D}" -v var2="${col}" -F: 'BEGIN{x} {for(i=0; i<NR; i++){if(NR==var1&&NF==var2){x=$NF}}}END{print x}' ./$table_name`
#echo $res
sed -i ''"$I_D"'s/'"`awk -v var1="${I_D}" -v var2="${col}" -F: 'BEGIN{x} {for(i=0; i<NR; i++){if(NR==var1&&NF==var2){x=$NF}}}END{print x}' Databases/$database_name/$table_name`"'/'"$value"'/' Databases/$database_name/$table_name

