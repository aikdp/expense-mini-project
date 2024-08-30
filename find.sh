#!/bin/bash

#list of all files in Source dirctory
SOURCE_DIR=/home/ec2-user/logs

FILES=$(find $SOURCE_DIR -type f)
echo "list of files are: $FILES"