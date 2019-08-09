#!/bin/bash

URL="$1"
FILE="$2"
LOG_FILE="/tmp/download_$$.log" # for error msg

usage()
{
    echo "Usage:" >&2
    echo " $0 url filename" >&2
    echo "Where:" >&2
    echo " url is an HTTP url to a file (use double quotes around the url)" >&2
    echo " filename is the filename to use for the resulting file" >&2
    exit 1
}

if (( $# != 2 ))
then
    usage
fi

wget "$URL" -O "$FILE" &> "$LOG_FILE"
if (( $? != 0 ))
then
    echo "Could not download file." >&2
    echo "See $LOG_FILE for details." >&2
    exit 1
else
    echo "Saved $FILE from $URL"
fi

