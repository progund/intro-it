#!/bin/bash

FILE="welcome.sh"
DATE=$(date +%Y-%m-%d)
BACKUP="$FILE.bak.$DATE"
cp "$FILE" "$BACKUP"
gzip -9 "$BACKUP"
