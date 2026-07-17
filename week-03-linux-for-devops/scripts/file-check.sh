#!/bin/bash

directory="../test-folder"
file="../test-folder/sample.txt"

if [ -d "$directory" ]; then
    echo "Directory exists."
else
    echo "Directory does not exist."
fi

if [ -f "$file" ]; then
    echo "File exists."
else
    echo "File does not exist."
fi
