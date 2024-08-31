#!/bin/bash

#list of all files in Source dirctory
SOURCE_DIR=/home/ec2-user/app-logs

# FILES=$(find $SOURCE_DIR -type f)
# FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
FILES=$(find $SOURCE_DIR -type f -name "*.log")
echo "list of files are: $FILES"