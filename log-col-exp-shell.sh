#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p $LOG_FOLDER
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"

ROOT(){
if [ $USERID -eq 0 ] 
then 
    echo -e "USER have a $G ROOT ACCESS $N" | tee -a $LOG_FILE
else
    echo -e "USER does not have ROOT ACCESS, $R Please LOGIN as a ROOT USER $N" | tee -a $LOG_FILE
    exit 1
fi
}
CHECK(){
    if [ $1 -eq  0 ]
    then 
        echo -e "$2 is $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is $R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi    
}
ROOT
dnf list installed mysql | tee -a $LOG_FILE
if [ $? -eq 0 ]
then 
    echo -e "$Y MYSQL Server is already installed.$N"
else
    echo -e "MYSQL Server is not Installed, $R Please install MSQL $N"
    
    dnf install mysql-server -y | tee -a $LOG_FILE
    CHECK $? "MYSQL installation"  
fi    
systemctl enable mysqld &>>$LOG_FILE
CHECK $? "ENABLING MYSQL Service"
 
systemctl start mysqld &>>$LOG_FILE
CHECK $? "STARTING MYSQL Service"

mysql -h mysql.telugudevops.online -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE
if [ $? -eq 0 ]
then 
     echo -e "$Y ROOT Password is already SETUP,,SKIPPING $N"
else 
    echo -e "ROOT Password is not setup,,,$R Please setup MYSQL ROOT Password $N"
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG_FILE
    CHECK $? "ROOT PASSWORD SETUP"
fi    