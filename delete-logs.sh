#!/bin/bash

#Delete the log files in given Directory which is oldee than 14 days
# 1.which directory should delete
# 2.is that directory exists
# 3.find the files
# 4. delete them

SOURCE_DIR=/home/ec2-user/app-logs      #create logs directory, you can give dirctory dynamicall as well (like SOURCE_DIR=$1)
if [ -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR is exists"
else
    echo "$SOURCE_DIR not exist, please give coreect $SOURCE_DIR Directory"
    exit 1
fi
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "List of existing log files are: $FILES"               #As of this line, we did print or show the existing log files

while read -r file #check removing IFS= and -r for better understanding 
do
    echo "Deleting list of existing files: $file"       #this line is for just to know the user which files are deleting will show on the terminal
    # rm -rf $file
done <<< $FILES                #this is for giving input, so loop will contimue untill all files are delete