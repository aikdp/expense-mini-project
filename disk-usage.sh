#!/bin/bash

#Disk usage, xfs is important
DU=$(df -hT | grep xfs)

#disk threshold, howevr in real time projects it should be 75
DT=5 

#Adding colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#checking line by line in while loop
while IFS= read -r line
do
    #only xfs disk utilization
    U=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)

    #partition name or directories names
    DIR_NAME=$(echo $line | grep xfs | awk -F " " '{print $NF}') 

    #condtion if Usage is greater than Threshold
    if [ "$U" -ge $DT ]
    then
        echo -e "$Y $DIR_NAME $N disk usage is more than $DT, $Y Current Usage Value is $N : $U...$R PLEASE CHECK $N"
    fi

#giving input to while loop untill all line completed   
done <<< $DU  