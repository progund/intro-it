#!/bin/bash

URL="$1"
FILE="$2"

wget "$URL" -O "$FILE"
