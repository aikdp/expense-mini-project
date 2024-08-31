#!/bin/bash

#deleting logs in source directiry and move to destination directory

SOURCE_DIR=$1 #Dynamiclly giving Source Directory

if [ ! -d $SOURCE_DIR ]
then
    echo "SOurce Diractory Doesn't exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "list of files are: $FILES"
while IFS= read -r file
do
    echo "Deleting list of files: $file"
    # rm -rf $file
done <<< $FILES

