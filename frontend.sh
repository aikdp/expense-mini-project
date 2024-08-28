#!/bin/bash

#Urser id check
USERID=$(id -u)
LOG_FOLDER="/var/log/expense-frontend"
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

dnf install nginx -y &>>$LOG_FILE
CHECK $? "Installing Nginx"

systemctl enable nginx &>>$LOG_FILE
CHECK $? "Enabling Nginx"

systemctl start nginx &>>$LOG_FILE
CHECK $? "Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
CHECK $? "Removing default website from Nginx"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
CHECK $? "Downlaod frontend application code"

cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/frontend.zip
CHECK $? "Extracting frontend code"

cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE
CHECK $? "Copied frontend expense conf file for reverse proxy to Backend"

systemctl restart nginx &>>$LOG_FILE
CHECK $? "Restarting Nginx"