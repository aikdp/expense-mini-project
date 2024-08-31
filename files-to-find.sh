#!/bin/bash



SOURCE_DIR=$1    #create logs directory, you can give dirctory dynamicall as well (like SOURCE_DIR=$1)

USAGE(){
    echo "USAGE: Please give arguments like sh <filename> <sourch-dir-path> ... "
    exit 1
}
USAGE
if [ -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR is exists"
else
    echo "$SOURCE_DIR not exist, please give coreect $SOURCE_DIR Directory"
    exit 1
fi
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "List of existing log files are: $FILES"               #As of this line, we did print or show the existing log files