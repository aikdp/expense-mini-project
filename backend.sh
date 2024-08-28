#!/bin/bash

#Urser id check
USERID=$(id -u)
LOG_FOLDER="/var/log/expense-backend"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_FOLDER/$CRIPT_NAME-$TIME.log"
mkdir -p $LOG_FOLDER

#Clolors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

ROOT(){
    if [ $USERID -eq 0 ]
    then
        echo -e "USER has ROOT Access."
    else
        echo -e "USER does not have root access..Please login as ROOT USER"
        exit 1
    fi            
}
CHECK(){
    if [ $1 -eq 0 ]
    then
        echo "$2 is...SUCCESS"
    else
        echo "$2 is ...FAILED"
        exit 1
    fi
}
ROOT


dnf module disable nodejs -y
CHECK $? "DISABLE Nodejs modules"

dnf module enable nodejs:20 -y
CHECK $? "ENABLE Nodejs 20 modules"

dnf install nodejs -y
CHECK $? "INSTALLING nodejs"

id expense
if [ $? -eq 0 ]
then 
    echo "User expense Already Exists,..SKIP ADDING EXPENSE USER"
else
    echo "User expense not createdExists,..Please ADD USER EXPENSE"
    useradd expense
    CHECK $? "Adding user Expense"
fi

mkdir -p /app
CHECK $? "Folder /app is creating"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
CHECK $? "Download Backend application code"

cd /app
CHECK $? "Going to /app folder"

rm -rf /app/*
unzip /tmp/backend.zip
CHECK $? "unzipping backend appliaction"

cd /app
npm install
CHECk $? "Installing Dependcies of Backend application"

cp /home/ec2-user/expense-backend/backend.service /etc/systemd/system/backend.service
CHECK $? "Copied backend service for API call to DB"

dnf install mysql -y
CHECK $? "Installing MYSQL"

mysql -h mysql.telugudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql
CHECK $? "Loading SCHEMA to backend.sql"

systemctl daemon-reload
CHECK $? "DEAMON relaod"

systemctl start backend
CHECK $? "START Backend"

systemctl enable backend
CHECK $? "Enabling Backend"

systemctl restart backend
CHECK $? "RESTART Backend SERVICE"