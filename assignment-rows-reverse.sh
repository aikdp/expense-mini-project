#!/bin/bash

#Convert Rows to Columns, Columns to Rows

# datamash -W transpose < rowtext.txt
xargs -n < file.txt