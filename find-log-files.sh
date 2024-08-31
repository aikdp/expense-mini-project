#!/bin/bash

#Checking log files in given Directory which is oldee than 14 days
# 1.which directory is in the log files
# 2.is that directory exists
# 3.find the files


SOURCE_DIR=/home/ec2-user/durga      #create logs directory
if [ -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR is exists"
else
    echo "$SOURCE_DIR not exist, please give coreect $SOURCE_DIR Directory"
    exit 1
fi
# FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)  # * is for all in the dirctory .log files
# FILES=$(find $SOURCE_DIR -type f -name "*.txt" -mtime +14)           # -type f means files

# FILES=$(find $SOURCE_DIR -type f -name "*.js" -mtime +14)   #you can use all commands
FILES=$(find $SOURCE_DIR -type f)   #all files in that dirctory
echo "List of existing log files are: $FILES"               #As of this line, we did print or show the existing log files
