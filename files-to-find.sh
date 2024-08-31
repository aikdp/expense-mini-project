#!/bin/bash



SOURCE_DIR=/home/ec2-user/app-logs    #create logs directory, you can give dirctory dynamicall as well (like SOURCE_DIR=$1)
if [ -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR is exists"
else
    echo "$SOURCE_DIR not exist, please give coreect $SOURCE_DIR Directory"
    exit 1
fi
FILES=$(find $SOURCE_DIR -name ".log" -mtime +14) #-name ".log" -mtime -14)
echo "List of existing log files are: $FILES"               #As of this line, we did print or show the existing log files

# while IFS= read -r file
# do
#     echo "List of existing .log files: $file"       #this line is for just to know the user which files are deleting will show on the terminal
    
# done <<< $FILES            #this is for giving input, so loop will contimue untill all files are delete