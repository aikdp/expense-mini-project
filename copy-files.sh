#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2


USAGE(){
    echo "USAGE:: is please give source directoy path and Destination Dir path"
    exit 1
}
cp $SOURCE_DIR $DEST_DIR

echo "Copying files from source dir to Destination DIR is started at: $(date)" 
