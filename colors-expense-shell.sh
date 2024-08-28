#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -eq 0 ] 
then 
    echo -e "USER have a $G ROOT ACCESS $N"
else
    echo -e "USER does not have ROOT ACCESS, $R Please LOGIN as a ROOT USER $N"
    exit 1
fi

CHECK(){
    if [ $1 -eq  0 ]
    then 
        echo -e "$2 is $G SUCCESS $N"
    else
        echo -e "$2 is $R FAILED $N"
        exit 1
    fi    
}

dnf list installed mysql
if [ $? -eq 0 ]
then 
    echo -e "$Y MYSQL Server is already installed.$N"
else
    echo -e "MYSQL Server is not Installed, $R Please install MSQL $N"
    dnf install mysql-server -y
    CHECK $? "MYSQL installation"  
fi    

systemctl enable mysqld
    CHECK $? "ENABLING MYSQL Service"
 
systemctl start mysqld
    CHECK $? "STARTING MYSQL Service"

mysql -h mysql.telugudevops.online -u root -pExpenseApp@1 -e 'show databases;'
   if [ $? -eq 0 ]
   then 
        echo -e "$Y ROOT Password is already SETUP,,SKIPPING $N"
    else 
        echo -e "ROOT Password is not setup,,,$R Please setup MYSQL ROOT Password $N"
        mysql_secure_installation --set-root-pass ExpenseApp@1
        CHECK $? "ROOT PASSWORD SETUP"
    fi    