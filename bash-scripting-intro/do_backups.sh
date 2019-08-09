#!/bin/bash

DATE=$(date +%Y-%m-%d)
SUFFIX=".bak.$DATE"
bad_files=""

for file in "$@"
do
    if [[ -e "$file" ]]
    then
        cp "$file" "$file$SUFFIX" && gzip -9 "$file$SUFFIX"
    else
        bad_files="$bad_files $file"
    fi
done

if [[ -z "$bad_files" ]]
then
    exit 0
else
    echo "These files were not found: $bad_files" >&2 # redirect to std err
    exit 1
fi
