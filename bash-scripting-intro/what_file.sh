#!/bin/bash

MP3_1="ID3..."
JAVA_CLASS="cafe babe"
JAVA_SOURCE_1="package "
JAVA_SOURCE_2="import "
JAVA_SOURCE_3="public class"
TEXT_FILE=false
BASH_SCRIPT="#!/bin/bash"
PNG=".PNG."
ZIP="50 4b 03 04"
JPG="4a 46 49 46"
GZIP="1f 8b"
SQLITE3="SQLite format 3"

file="$1"


# check java source
JAVA_SOURCE_SCORE=0
JAVA_CLASS_SCORE=0
BASH_SCRIPT_SCORE=0
PNG_SCORE=0
ZIP_SCORE=0
GZIP_SCORE=0
JPG_SCORE=0
SQLITE3_SCORE=0

xxd -l32 -c32 -g1 "$file" |
    cut -d ' ' -f2-34 |
    egrep -vq '[8-9a-f][a-f0-9]|0[1-8]' && TEXT_FILE=true
xxd -l32 "$file" | awk '{print $10;}' | grep -q "$PNG" && ((PNG_SCORE++))
xxd -l64 -c32 "$file" | grep -q "$JAVA_SOURCE_1" && ((JAVA_SOURCE_SCORE++))
xxd -l64 -c32 "$file" | grep -q "$JAVA_SOURCE_2" && ((JAVA_SOURCE_SCORE++))
xxd -l64 -c32 "$file" | grep -q "$JAVA_SOURCE_3" && ((JAVA_SOURCE_SCORE++))
xxd -l4 "$file" | grep -q "$JAVA_CLASS" && ((JAVA_CLASS_SCORE++))
xxd -l32 "$file" | grep -q "$BASH_SCRIPT" && ((BASH_SCRIPT_SCORE++))
xxd -l32 -c32 -g1 "$file" | cut -d ' ' -f2-34|grep -q "$ZIP" && ((ZIP_SCORE++))
xxd -l32 -c32 -g1 "$file" | cut -d ' ' -f2-34|grep -q "$GZIP" && ((GZIP_SCORE++))
xxd -l32 -c32 -g1 "$file" | cut -d ' ' -f2-34|grep -q "$JPG" && ((JPG_SCORE++))
xxd -l16 "$file" | grep -q "$SQLITE3" && ((SQLITE3_SCORE++))

filetype="unknown"

#  The below is not an example on how to use or write
#+ tests using if. It's a pragmatic way of seeing what
#+ tests were successful.

if $TEXT_FILE
then
    echo -n "Possible text file "
    filetype="Text file"
fi

if $TEXT_FILE && (( JAVA_SOURCE_SCORE > 0 ))
then
    filetype="Possible Java source code, score $JAVA_SOURCE_SCORE / 3"
fi

if (( JAVA_CLASS_SCORE > 0 ))
then
    filetype="Possible Java class file"
fi

if (( BASH_SCRIPT_SCORE > 0 ))
then
    filetype="Possible Bash script"
fi

if (( PNG_SCORE > 0 ))
then
    filetype="Possible PNG image"
fi

if (( ZIP_SCORE > 0 ))
then
    filetype="Zip file"
fi

if (( JPG_SCORE > 0 ))
then
    filetype="JPEG image file"
fi

if (( SQLITE3_SCORE > 0 ))
then
    filetype="SQLite Database file"
fi

if (( GZIP_SCORE > 0 ))
then
    filetype="gzip compressed file"
fi

echo "$file: $filetype"
