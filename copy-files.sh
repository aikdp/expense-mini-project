#!/bin/bash

SOURCE_DIR=$(/home/ec2-user/durga)
DEST_DIR=$(/home/ec2-user/prasad)


# USAGE(){
#     echo "USAGE:: is please give source directoy path and Destination Dir path"
#     exit 1
# }
# USAGE
# if [ -d $SOURCE_DIR ]
# then
#     echo "enter source dirctory path: $SOURCE_DIR"
cp -f $SOURCE_DIR $DEST_DIR

# echo "Copying files from source dir to Destination DIR is started at: $(date)" 
