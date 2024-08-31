#!/bin/bash


DU=$(df -hT | grep xfs)
DT=5 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

while IFS= read -r line
do
    U=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    DIR_NAME=$(echo $line | grep xfs | awk -F " " '{print $NF}') 
    if [ "$U" -ge $DT ]
    then
        echo -e "$Y $DIR_NAME $N disk usage is more than $DT, $Y Current Usage Value is $N : $U...$R PLEASE CHECK $N"
    fi
done <<< $DU