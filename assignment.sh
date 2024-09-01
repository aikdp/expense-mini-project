#!/bin/bash

#Q:Display top 5 frequntly repeated words?
#Write a script that reads a text file and counts the occurrences of each word, 
#display the top 5 most frequent words along with their counts.


while IFS= read file
do
    if [ ! -z $file ]
    then
        echo "text files is not empty"
        TOP_OCR=$( cat ${text.txt} | uniq -c | tr -i -o '\n' " " | head -5)
        echo "top most frequent words along with counts: $TOP_OCR"
    else
        echo "Text file empty, please check"
        exit 1
    fi
done <${text.txt}
