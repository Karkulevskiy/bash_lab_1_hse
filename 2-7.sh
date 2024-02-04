#!/bin/bash
#This is a comment
#Use local variables:
#userName -> User name
#first -> start index of sequence
#second -> end index of sequence
#help -> for comparing --help with variable
userName=$1
first=$2
second=$3
help="--help"
#instructions for help
if [[ $userName == $help ]];then
	echo "INSTRUCTIONS"
	echo "param1 (write user name), param2(first sequence), param3(second sequence)"
	echo "Exit codes: Error(-1), Success(0)"
 	echo "File users.csv will be saved with path: /home/users.csv"
else	
	#Handle error with exit code -1 if the arguments were wrong
	if [ $first -gt $second ] || [ $first -lt 0 ] || [ $second -lt 0 ];then
		 echo "Error (-1): sequence number should be less or equal to second"
	else	#Write names of columns is csv file
		echo "User name		       Sequence number			Password" >> $HOME/users.csv
		while [ $first -le $second ] #cycle with incrementing param index and writting in file
		do #if file dosn't exist, he will be created
			echo "$userName		$first			$(pwgen -s 20 -1)" >> $HOME/users.csv #append data
			first=$[$first + 1]
		done
		echo "Success (0)" #return with exit code 0 -> success
	fi
fi
