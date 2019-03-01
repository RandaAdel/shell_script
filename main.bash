#!/bin/bash
x=`ls | grep -wc Databases`

if test $x -eq 0
then
	mkdir Databases
else 
	select choice in CREATE_DATABASE VIEW_DATABASE DELETE_DATABASE Exit
	do
		case $choice in 
			CREATE_DATABASE) 
				read -p "please enter your database name : " name
				mkdir Databases/$name
				;;	
			VIEW_DATABASE)
				ls Databases
				read -p "please enter your database name : " database_name
				export database_name
				select choice1 in CREATE_TABLE VIEW_TABLES DELETE_TABLE Exit
				do
					case $choice1 in
						CREATE_TABLE)
							chmod +x Desktop/create
							. ./Desktop/create
						;;
						VIEW_TABLES)
							ls Databases/$database_name | grep -v meta
							read -p "please enter your table name : " table_name
							export table_name
							select choice2 in SELECT INSERT UPDATE DELETE Exit
							do
								case $choice2 in
								SELECT)
									chmod +x Desktop/select
									. ./Desktop/select
								;;								
								INSERT)

									chmod +x Desktop/insert
									. ./Desktop/insert
								;;	
								UPDATE)

									chmod +x Desktop/update
									. ./Desktop/update
								;;	
								DELETE)

									chmod +x Desktop/delete
									. ./Desktop/delete
								;;	

								Exit)
									break;;
								esac
							done
						;;
						DELETE_TABLE)
							read -p "please enter your table name : " table_name1
							rm Databases/$database_name/$table_name1
							rm Databases/$database_name/meta_$table_name1
						;;

						Exit)
							break
						;;
					esac
				done
				;;
			DELETE_DATABASE)
				read -p "please enter your database name : " name
				rm -r Databases/$name
				;;
			Exit)
				break				
			;;
			*)
			;;
		esac
	done
fi



