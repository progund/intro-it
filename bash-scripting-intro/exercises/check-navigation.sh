#!/bin/bash

BASE_URL="http://wiki.juneday.se/mediawiki/index.php/"

START_PAGE="$1"
DIRECTION="$2"
if (( $# != 2 ))
then
    echo "Usage: $0 start_page direction" >&2
    echo " Where direction is one of 'forward' or 'backward'"
    exit 1
fi

page=$START_PAGE
next=$(GET "${BASE_URL}${START_PAGE}" | tr '•' '\n'|grep '">Next'| grep -Po '\K"/mediawiki.*" ')
prev=$(GET "${BASE_URL}${START_PAGE}" | grep Previous| tr '•' '\n'|grep Previous | grep -Po '\K"/mediawiki.*"'  | cut -d ' ' -f1)
while [[ "$prev" =~ .*/mediawiki.* ]]
do
    echo $BASE_URL$page
    echo "$page has:"
    echo " next: $next"
    echo " prev: $prev"
    if [[ "$DIRECTION" = "forward" ]]
    then
        page=$(echo "$next" | cut -d '/' -f4 | tr -d '"')
    elif [[ "$DIRECTION" = "backward" ]]
    then
        page=$(echo "$prev" | cut -d '/' -f4 | tr -d '"')
    else
        echo "Unknown direction, please use forward or backward" >&2
        exit 2
    fi
    next=$(GET "${BASE_URL}${page}" | tr '•' '\n'|grep '">Next'| grep -Po '\K"/mediawiki.*" '  | cut -d ' ' -f1)
    prev=$(GET "${BASE_URL}${page}" | grep Previous| tr '•' '\n'|grep Previous | grep -Po '\K"/mediawiki.*"' | cut -d ' ' -f1)
    echo " *** "
done

