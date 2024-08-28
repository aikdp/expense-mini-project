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
        echo -e "$G USER has ROOT Access.$N" | tee -a $LOG_FILE
    else
        echo -e "USER does not have root access..Please login as ROOT USER" | tee -a $LOG_FILE
        exit 1
    fi            
}
CHECK(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is...$G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ...$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
}
ROOT


dnf module disable nodejs -y &>>$LOG_FILE
CHECK $? "DISABLE Nodejs modules"

dnf module enable nodejs:20 -y &>>$LOG_FILE 
CHECK $? "ENABLE Nodejs 20 module"

dnf install nodejs -y &>>$LOG_FILE
CHECK $? "INSTALLING nodejs"

id expense &>>$LOG_FILE
if [ $? -eq 0 ]
then 
    echo -e "User expense Already Exists,..$Y SKIP ADDING EXPENSE USER $N" | tee -a $LOG_FILE
else
    echo -e "$R User expense not Exists,..Please ADD USER EXPENSE $N" | tee -a $LOG_FILE
    useradd expense &>>$LOG_FILE
    CHECK $? "Adding user Expense"
fi

mkdir -p /app
CHECK $? "Folder /app is creating"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE
CHECK $? "Downloaded Backend application code"

cd /app
CHECK $? "Going to /app folder"

rm -rf /app/* &>>$LOG_FILE
unzip /tmp/backend.zip &>>$LOG_FILE
CHECK $? "unzipping backend appliaction"

cd /app
npm install &>>$LOG_FILE
CHECK $? "Installing Dependcies of Backend application"

cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOG_FILE
CHECK $? "Copied backend service for API call to DB"

dnf install mysql -y &>>$LOG_FILE
CHECK $? "Installing MYSQL"

mysql -h mysql.telugudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE
CHECK $? "Loading SCHEMA to backend.sql"

systemctl daemon-reload &>>$LOG_FILE
CHECK $? "DEAMON relaod"

systemctl start backend &>>$LOG_FILE
CHECK $? "START Backend"

systemctl enable backend &>>$LOG_FILE
CHECK $? "Enabling Backend"

systemctl restart backend &>>$LOG_FILE
CHECK $? "RESTART Backend SERVICE"