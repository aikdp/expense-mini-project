#!/bin/bash

#list of all files in Source dirctory
SOURCE_DIR=/home/ec2-user/app-logs

# FILES=$(find $SOURCE_DIR -type f)
# FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)        #show all .log files older than 14 days
FILES=$(find $SOURCE_DIR -type f -mtime +10)             #print all .log files without days means all .log files
echo "list of files are: $FILES"