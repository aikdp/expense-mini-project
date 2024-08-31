#!/bin/bash

#deleting logs in source directiry
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=/home/ec2-user/app-logs   #Dynamiclly giving Source Directory

if [ -d $SOURCE_DIR ]
then
    echo -e "$Y SOurce diractory exist $N"

else
    echo -e "$R SOurce Diractory Doesn't exist $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo -e "$Y list of files are:$N $FILES"
while IFS= read -r file
do
    echo -e "$Y Deleting list of files: $N $file"
    rm -rf $file
done <<< $FILES

