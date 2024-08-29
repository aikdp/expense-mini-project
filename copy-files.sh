#!/bin/bash

# SOURCE_DIR=$1
# DEST_DIR=$2

# USAGE(){
#     echo "USAGE:: is please give source directoy path and Destination Dir path"
#     exit 1
# }

# if [ -d $SOURCE_DIR ]
# then
#     echo "enter source dirctory path: $1"
# else
#     echo "Please give existing  source dirctory"
#     exit 1
# fi
# if [ -d $DEST_DIR ]
# then
#     echo "enter Destination dirctory path: $2"
# else
#     echo "Please give existing destination dirctory path"
#     exit 1
# fi

#     cp $SOURCE_DIR $DEST_DIR

# echo "Copying files from source dir to Destination DIR is started at: $(date)" 


USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2

if [ $? -ne 0 ]
then
    echo "Please run the script as a User Privilages"
    exit 1
if

if [ -d $SOURCE_DIR ]
then
    echo "Source directory exist"
    FILES=$(find $SOURCE_DIR -type f)
    LIST_FILE=$(echo $FILES)
else 
    echo "Please enter correct Source directory path"
    exit 1
fi
if [ -d $DEST_DIR ]
then 
    echo "Destination Directory Exists"
    cp $LIST_FILE $DEST_DIR
    if [ $? -eq 0 ]
    then
        echo "Copyinng files ..SUCESS"
    else
        echo "Copying files...FAILED"
        exit 1
    fi
else
    echo "Please enetr correct Destination Directory PATH"
    exit 1
fi
