#!/bin/bash

# #Checking commands if we enter wrong command also execution not stopped
# echo "Hello world"

# echooo "heloo world ..Failure"

# echo "Hello world after failure"

#Checking commands if we enter wrong command, execution should stop
set -e 
echo "Hello world"

echooo "heloo world ..Failure"

echo "Hello world after failure"
