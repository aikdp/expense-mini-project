#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2

USAGE(){
    echo "USAGE:: is please give source directoy path and Destination Dir path"
    exit 1
}

if [ -d $SOURCE_DIR ]
then
    echo "enter source dirctory path: $1"
else
    echo "Please give existing  source dirctory"
    exit 1
fi
if [ -d $DEST_DIR ]
then
    echo "enter Destination dirctory path: $2"
else
    echo "Please give existing destination dirctory path"
    exit 1
fi

    cp $SOURCE_DIR $DEST_DIR

echo "Copying files from source dir to Destination DIR is started at: $(date)" 
