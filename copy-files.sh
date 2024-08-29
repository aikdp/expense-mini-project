#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2


USAGE(){
    echo "USAGE:: is please give source directoy path and Destination Dir path"
    exit 1
}
USAGE
if [ ! -d $SOURCE_DIR & $DEST_DIR ]
then 
    echo "enter source dirctory path: $SOURCE_DIR"
    echo "enter source dirctory path: $DEST_DIR"
    cp $SOURCE_DIR $DEST_DIR
    exit 1
fi

echo "Copying files from source dir to Destination DIR is started at: $(date)" 
