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
    if [ $? -eq  0 ]
    then 
        echo "MYSQL is SUCCESSFULLY Installed"
    else
        echo "MYSQL is not installed"
        exit 1
    fi    
fi    
systemctl list-unit-files --mysqld=service --state=enabled
if [ $? -eq 0 ]
then 
    echo "MYSQL service already ENABLED"
else 
    echo "MYSQL service in not enabled, PLease ENABLE MYSQL"
    systemctl enable mysqld
    if [ $? -eq  0 ]
    then 
        echo "MYSQL is SUCCESSFULLY ENABLED"
    else
        echo "MYSQL is not ENABLED"
        exit 1
    fi  
fi 
systemctl --mysqld=service --state=running
if [ $? -eq 0 ]
then 
    echo "MYSQL service already STARTED"
else 
    echo "MYSQL service in not STARTED, PLease START MYSQL"
    systemctl start mysqld
    if [ $? -eq  0 ]
    then 
        echo "MYSQL is SUCCESSFULLY STARTED"
    else
        echo "MYSQL is not STARTED"
        exit 1
    fi  
fi 