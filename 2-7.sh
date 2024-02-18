#!/bin/bash
#This is a comment
#Use local variables:
#first -> start index of sequence
#second -> end index of sequence
#help -> for comparing --help with variable
first=$1
second=$2
regex='^[0-9]+$'
#instructions for help
if [ "$first" = "--help" ];then
	echo "INSTRUCTIONS:"
	echo "STDIN: ./script <<< [user name]  OPTIONS(first sequence) OPTIONS(second sequence)"
	echo "Exit codes: Error(-1), Success(0)" >&2
	exit 0
else
	read userName
	if [ -z "$userName" ];then
		echo "User name can't be null or empty" >&2
		exit -1
	fi
	#Handle error with exit code -1 if the arguments were wrong
	if [ -z $first ] || [ -z $second ];then
		echo "Sequence or user name can't be null" >&2
		exit -1
	fi
	if ! [[ "$first" == ?(-)+([0-9]) ]] || ! [[ "$second" == ?(-)+([0-9]) ]];then
		echo "Sequence must be a number" >&2
		exit -1
	fi
	if [ $first -gt $second ] || [ $first -lt 0 ] || [ $second -lt 0 ];then
		 echo "Error (-1): sequence number should be less or equal to second" >&2
		 exit -1
	else	#Write names of columns is csv file
		echo "User name,Sequence number,Password" >> $HOME/users.csv
		while [ $first -le $second ] #cycle with incrementing param index and writting in file
		do #if file dosn't exist, he will be created
			echo "$userName,$first,$(pwgen -s 20 -1)" >> $HOME/users.csv #append data
			first=$[$first + 1]
		done
		echo "Success (0)" >&2 #return with exit code 0 -> success
		exit 0
	fi
fi
