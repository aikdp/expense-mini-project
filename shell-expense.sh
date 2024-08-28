#!/bin/bash

USERID=$(id -u)

if [ $USERID -eq 0 ]
then 
    echo "USER have a ROOT ACCESS"
else
    echo "USER does not have ROOT ACCESS, Please LOGIN as a ROOT USER"
    exit 1
fi

CHECK(){
    if [ $1 -eq  0 ]
    then 
        echo "$2 is SUCCESS"
    else
        echo "$2 is FAILED"
        exit 1
    fi    
}

dnf list installed mysql
if [ $? -eq 0 ]
then 
    echo "MYSQL Server is already installed."
else
    echo "MYSQL Server is not Installed, please install MSQL"
    dnf install mysql-server -y
    CHECK $? "MYSQL installation"  
fi    

systemctl enable mysqld
    CHECK $? " ENABLING MYSQL Service"
 
systemctl start mysqld
    CHECK $? "STARTING MYSQL Service"

mysql -h mysql.telugudevops.online -u root -pExpenseApp@1 -e 'show databases;'
   if [ $? -eq 0 ]
   then 
        echo "ROOT Password is already SETUP"
    else 
        echo "Please setup ROOT Password"
        mysql_secure_installation --set-root-pass ExpenseApp@1
    fi    