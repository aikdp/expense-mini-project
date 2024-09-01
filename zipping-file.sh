#!/bin/bash

#Colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#Variables 
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

USAGE(){
    echo  -e "$R USAGE: please give argumnets like sh <filename> <Source DIR> Destionation DIR><days> $N"
    exit 1
}

#IF total number of arguments are less than 2 then exit
if [ $# -lt 2 ]
then
    USAGE
fi

#Source dircotory check
if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$R $SOURCE_DIR not exist $N, please give coreect $SOURCE_DIR Directory"
    exit 1
fi

#SDestination dircotory check
if [ ! -d $DEST_DIR ]
then 
    echo -e "$R $DEST_DIR not exist $N, please give coreect $DEST_DIR Directory"
    exit 1
fi

#find out All .log files in source direcory older than given days
FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS)
echo -e "$Y List of all log files are $N: $FILES"

#if -z means empty, if log files are empty/not there, condition wil true
if [ -z $FILES ]
then 
    echo -e "$R Files are NOT FOUND $N"
    exit 1
else
    echo -e "$G Files are found $N"

    #Path to save zipped files
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"

    #Zipping older than given days log files and moved to given path
    find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS | zip "$ZIP_FILE" -@
    if [ -f $ZIP_FILE ]
    then 
        echo -e "$G All log files older than 14 dyas are successfully ZIPPED $N"

        #Read file by file in loop by using IFS -r 
        while IFS= read -r file
        do
            echo -e "$Y Deleting all log files $N: $file"

            #remiove files
            rm -rf $file

        #Giving input to loop for untill all files are completed to remove  
        done <<< $FILES     
    else
        echo -e "$R All log files older than 14 dyas are NOT ZIPPED $N"
        exit 1
    fi
    
fi
