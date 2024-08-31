#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

USAGE(){
    echo  -e "$R USAGE: please give argumnets like sh <filename> <Source DIR> Destionation DIR><days> $N"
    exit 1
}
if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$R $SOURCE_DIR not exist $N, please give coreect $SOURCE_DIR Directory"
    exit 1
fi
if [ ! -d $DEST_DIR ]
then 
    echo -e "$R $DEST_DIR not exist $N, please give coreect $DEST_DIR Directory"
    exit 1
fi
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo -e "$Y List of all log files are:$N $FILES"

if [ ! -z $FILES ]
then 
    echo -e "$G Files are found $N"
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip "$ZIP_FILE" -@
    if [ -f $ZIP_FILE ]
    then 
        echo -e "$G All log files older than 14 dyas are successfully ZIPPED $N"
        while IFS= read -r file
        do
            echo -e "$Y Deleting all log files:$N $file"
            rm -rf $file
        done <<< $FILES 
    else
        echo -e "$R All log files older than 14 dyas are NOT ZIPPED $N"
        exit 1
    fi
else
    echo -e "$R Files are NOT FOUND $N"
    exit
fi
