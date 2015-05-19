#!/bin/bash
#Author: Kyle Agronick
#Email: agronick@gmail.com
 
#Usage: wallpaper_slideshow.sh [FOLDER] [MINUTES] --bootonly
#Randomly load pictures in FOLDER and display them and 
#display a new one every [MINUTES] minutes. 
#
# --bootonly	Load an random image and exit.
# 
#This script is best used when invoked from an autostart folder.


IS_NUM='^[0-9]+$'  


if [[  $@ == **makecmd** ]]; then  
	CMD="Copy and paste this command: 
$(readlink -f $0) $1"
	if [[  $2 != **makecmd** ]]; then
	CMD+=" $2 "
	fi
	if [[  $3 != **makecmd** ]]; then
	CMD+=" $3 "
	fi 
	echo -e "\n"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	echo $CMD
 	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	echo -e "\n"
	exit;
fi

if [ -z "$1" ];
    then echo 'You must enter a directory'
    exit
fi

MINS=2
if [[ $2 =~ $IS_NUM ]];
    then MINS=$2 
fi


MINS+="m" 
while true; do
	str=`find $1 -iregex '.*\.\(tga\|jpg\|gif\|png\|jpeg\)$' | shuf` 
	for item in $str
	do 
	   i="file:///$item" 
	   gsettings set org.gnome.desktop.background picture-uri $i  
	   if [[  $@ == **bootonly** ]]; then  
		exit;
	   fi
	   sleep $MINS
	done
done