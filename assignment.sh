#!/bin/bash

#Q:Display top 5 frequntly repeated words?
#Write a script that reads a text file and counts the occurrences of each word, 
#display the top 5 most frequent words along with their counts.

FN=text.txt

# while IFS= read line
# do
#     if [ ! -z $FN ]
#     then
#         echo "text files is not empty"
#         TOP_OCR=$( cat $FN | uniq -c | sort -nr | head -5)
#         echo "top most frequent words along with counts: $TOP_OCR"
#     else
#         echo "Text file empty, please check"
#         exit 1
#     fi
# done < $FN

sed -e 's/[^[:alpha:]]/ /g' $FN | tr '\n' " " | tr -s " " | tr " " '\n' | tr 'A-Z' 'a-z' | uniq -c | sort -nr | nl