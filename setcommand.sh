#!/bin/bash

# #Checking commands if we enter wrong command also execution not stopped
# echo "Hello world"

# echooo "heloo world ..Failure"

# echo "Hello world after failure"

#Setting the automatic exit, if we get an error
# set -e 
# echo "Hello world"

# echooo "heloo world ..Failure"

# echo "Hello world after failure"


#Checking commands if we enter wrong command, execution should stop
set -ex     #set -x is for code debug
echo "Hello world"

echooo "heloo world ..Failure"

echo "Hello world after failure"