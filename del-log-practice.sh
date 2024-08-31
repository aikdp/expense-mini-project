#!/bin/bash

#deleting logs in source directiry and move to destination directory

SOURCE_DIR=$1 #Dynamiclly giving Source Directory
DAYS=${2: -14}
USAGE(){
    echo "USAGE: sh <filename> <SOURCE_DIR> <DEST-DIR> <Days>,,,.PLease check"
}
USAGE

if [ ! -d $SOURCE_DIR ]
then
    echo "SOurce Diractory Doesn't exist"
    exit 1
fi

# if [ ! -d $DEST_DIR ]
# then
#     echo "Destination Diractory Doesn't exist"
#     exit 1
# fi

FILES=$(find $SOURCE_DIR -name ".log" -mtime +$DAYS)
echo "list of files are: $FILES"
while IFS= read -r file
do
    echo "Deleting list of files: $LF"
    # rm -rf $file
done <<< $FILES

