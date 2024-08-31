#!/bin/bash

#list of all files in Source dirctory
SOURCE_DIR=/home/ec2-user/app-logs

# FILES=$(find $SOURCE_DIR -type f)         #all files in that dirctory
# FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)        #show all .log files older than 14 days
# FILES=$(find $SOURCE_DIR -type f -mtime +10)            #print all files older than 10 days
FILES=$(find $SOURCE_DIR -name "*.log")             #all .log files in that dir 
echo "list of files are: $FILES"