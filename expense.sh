#!/bin/bash

USERID=$(id -u)

if [ $USERID -eq 0 ]
then 
    echo "USER have a ROOT ACCESS"
else
    echo "USER does not have ROOT ACCESS, Please LOGIN as a ROOT USER"
    exit 1
fi
dnf list installed mysql
if [ $? -eq 0 ]
then 
    echo "MYSQL Server is already installed."
else
    echo "MYSQL Server is not Installed, please install MSQL"
    dnf install mysql-server -y
    exit 1
fi    
systemctl list-unit-files --state=enabled
if [ $? -eq 0 ]
then 
    echo "MYSQL service already ENABLED"
else 
    echo "MYSQL service in not enabled, PLease ENABLE MYSQL"
    systemctl enable mysqld
    exit 1
fi 



