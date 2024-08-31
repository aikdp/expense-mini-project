#!/bin/bash

#zip source dir files and move zipped files to destion dir and delete files in source dir

SOURCE=$1
DEST_DIR=$2
DAYS=$3
TIME=$(date +%Y-%m-%d-%H-%M-%S)
USAGE(){
    echo "Please enter aruguments like: sh <FileName> <Source-Dir> <Dest_Dir> <Days>"
    exit
}
if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE ]
then 
    echo "Source directory does not Exist"
    exit 1
fi
if [ ! -d $DEST_DIR ]
then 
    echo "Destination directory does not Exist"
    exit 1
fi

FE=$(find $SOURCE -name "*.log" -mtime +$DAYS)
echo "List of log files older than $DAYS are: $FE"

if [ ! -z $FE ]
then 
    echo "Log files are FOund"
    ZIP_FILE="$DEST_DIR/app-logs-$TIME.zip"
    find $SOURCE -name "*.log" -mtime +DAYS | zip "$ZIP_FILE" -@
    if [ -f $ZIP_FILE ]
    then 
        echo "Log files Older than $DAYS is SUCCSESSFULLY ZIPPED"
        while IFS= read -r file
        do
            echo "Deleting log files are: $file"
            rm -rf $file
        done <<< $FE
    else
        echo "Log files older than $DAYS is NOT ZIPPED....FAILED"
        exit 1
    fi
else    
    echo "Log files are not found"
    exit 1
fi
        